//
//  ApiClient.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation
import UIKit

/// Performs all network requests over NSURLSession
/// All requests are handled on a global queue but all completion handler resolve on the main queue.
/// GET requests are retryed depending on the amount set in retryCountGET.
class ApiClient {
    
    enum ApiError: Error {
        case unknown
        case urlInvalid
        case invalidArgument
        case jsonParsingError
        case taskCanceled
        case httpError(Int)
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
    }
    
    /// For GET
    private var timeoutGET: TimeInterval = 10.0
    private var retryCountGET: Int = 2
    
    /// For PUT and POST requests
    private var timeoutUpload: TimeInterval = 10.0
    private var timeoutImageDownload: TimeInterval = 60.0
    private var timeoutImageUpload: TimeInterval = 60.0
    
    let baseURL: URL
    private let log = Logger()
    
    private var session: URLSession
    
    // The default headers sent with most requests
    var defaultHeaders: [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        // add any additional standard header you need here
        return headers
    }
    
    init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    /// Performs all network requests over NSURLSession
    ///
    /// - parameter request: The request to perform
    /// - parameter retryCount: How often the request should be retried on possible errors.
    /// - parameter completion: The completion handler. Either resolved with valid data or an error.
    ///                         HTTP status code which are outside the range 100-399 also complete as an error.
    @discardableResult private func performNetworkRequest(request: URLRequest, retryCount: Int, completion: @escaping (Result<Data>) -> ()) -> AsyncNetworkTask {
        // Show the network loading indicator
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let dataTask = session.dataTask(with: request as URLRequest) { [weak self] (resultData, urlResponse, resultingError) in
            guard let strongSelf = self else { return }
            // The task resolves on a background queue, therefore we must switch to the main queue for GUI tasks.
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            
            guard let data = resultData, let response = urlResponse as? HTTPURLResponse, resultingError == nil else {
                if let error = resultingError as NSError? {
                    strongSelf.log.error(String(describing: error))
                    
                    if retryCount > 0 {
                        let delayInMilliseconds = strongSelf.random(min: 300, max: 1000)
                        
                        if let requestUrl = request.url {
                            strongSelf.log.verbose("sessionDataTask retry count: \(retryCount) delayInMilliseconds: \(delayInMilliseconds) url: \(requestUrl.absoluteString)")
                        }
                        
                        // Delay the retry to give the network stack some time to repair itself
                        let delay = DispatchTime.now() + DispatchTimeInterval.milliseconds(delayInMilliseconds)
                        DispatchQueue.global().asyncAfter(deadline: delay) {
                            // Call GET recursively again with an decresed retryCount
                            strongSelf.performNetworkRequest(request: request, retryCount: retryCount - 1, completion: completion)
                        }
                    } else {
                        if error.domain == NSURLErrorDomain && error.code == -999 {
                            completion(Result.failure(ApiError.taskCanceled))
                        } else {
                            completion(Result.failure(error))
                            strongSelf.log.warning(error.description)
                        }
                    }
                }
                return
            }
            
            if response.statusCode < 400 {
                // Successfull completion
                completion(Result.success(data))
                return
            } else {
                #if DEBUG
                if let url = response.url?.absoluteString {
                    strongSelf.log.warning("HTTP error \(response.statusCode) on calling: \(url)\n\(String(describing: resultingError))")
                }
                #endif
                
                completion(Result.failure(ApiError.httpError(response.statusCode)))
            }
        }
        
        dataTask.resume()
        return AsyncNetworkTask(dataTask: dataTask)
    }
    
    func createUploadUrlRequest<T: Encodable>(url: URL,
                                              params: [String: String]?,
                                              headers: [String: String]?,
                                              uploadObject: T?,
                                              httpMethod: HTTPMethod) throws -> URLRequest {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw ApiError.urlInvalid }
        guard httpMethod == .post || httpMethod == .put else { throw ApiError.invalidArgument }
        
        if let params = params {
            var queryItems = [URLQueryItem]()
            for (key, value) in params {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let resultUrl = urlComponents.url else { throw ApiError.urlInvalid }
        log.info(resultUrl.absoluteString)
        var request = URLRequest(url: resultUrl,
                                 cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy,
                                 timeoutInterval: self.timeoutUpload)
        
        if let uploadObject = uploadObject {
            do {
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(uploadObject)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    log.info(jsonString)
                }
                request.httpBody = jsonData
            } catch let error {
                log.error(String(describing: error))
                throw ApiError.urlInvalid
            }
        }
        
        request.httpMethod = httpMethod.rawValue
        request.httpShouldHandleCookies = false
        
        if let headersToAttach = headers {
            for (key, value) in headersToAttach {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    func createGetUrlRequest(url: URL,
                             params: [String: String]?,
                             headers: [String: String]?) throws -> URLRequest {
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw ApiError.urlInvalid }
        
        // Attach params
        if let params = params {
            var queryItems = [URLQueryItem]()
            for (key, value) in params {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
            urlComponents.queryItems = queryItems
        }
        
        guard let resultUrl = urlComponents.url else { throw ApiError.urlInvalid }
        var request = URLRequest(url: resultUrl,
                                 cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = HTTPMethod.get.rawValue
        request.httpShouldHandleCookies = false
        
        if let headersToAttach = headers {
            for (key, value) in headersToAttach {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    func get<T: Decodable>(url: URL,
                           params: [String: String]?,
                           headers: [String: String]?,
                           completion: @escaping(Result<T>) -> ()) -> AsyncNetworkTask? {
        var task: AsyncNetworkTask?
        do {
            let request = try createGetUrlRequest(url: url,
                                                  params: params,
                                                  headers: headers)
            
            task = performNetworkRequest(request: request, retryCount: 0, completion: { (result) in
                switch result {
                case .success(let resultData):
                    do {
                        let jsonDecoder = JSONDecoder()
                        let entity: T = try jsonDecoder.decode(T.self, from: resultData)
                        DispatchQueue.main.async {
                            completion(Result.success(entity))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completion(Result.failure(error))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                }
            })
        } catch let error {
            DispatchQueue.main.async {
                completion(Result.failure(error))
            }
        }
        return task
    }
    
    func put<T: Encodable>(url: URL,
                           params: [String: String]?,
                           headers: [String: String]?,
                           uploadObject: T?,
                           completion: @escaping (Error?)->()) -> AsyncNetworkTask? {
        return send(url: url,
                    params: params,
                    headers: headers,
                    uploadObject: uploadObject,
                    httpMethod: .put,
                    completion: completion)
        
    }
    
    func post<T: Encodable>(url: URL,
                           params: [String: String]?,
                           headers: [String: String]?,
                           uploadObject: T?,
                           completion: @escaping (Error?)->()) -> AsyncNetworkTask? {
        return send(url: url,
                    params: params,
                    headers: headers,
                    uploadObject: uploadObject,
                    httpMethod: .put,
                    completion: completion)
        
    }
    
    private func send<T: Encodable>(url: URL,
                                    params: [String: String]?,
                                    headers: [String: String]?,
                                    uploadObject: T?,
                                    httpMethod: HTTPMethod,
                                    completion: @escaping (Error?)->()) -> AsyncNetworkTask? {
        var task: AsyncNetworkTask?
        do {
            let request = try createUploadUrlRequest(url: url,
                                                     params: params,
                                                     headers: headers,
                                                     uploadObject: uploadObject,
                                                     httpMethod: httpMethod)
            
            task = performNetworkRequest(request: request, retryCount: 0, completion: { (result) in
                switch result {
                case .success(let resultData):
                    self.log.info(String(describing: String(data: resultData, encoding: .utf8)))
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
            })
        } catch let error {
            DispatchQueue.main.async {
                completion(error)
            }
        }
        return task
    }
    
    private func random(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}








