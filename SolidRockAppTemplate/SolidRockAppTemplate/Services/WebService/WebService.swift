//
//  WebService.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol WebServiceProtocol {
    @discardableResult func search(searchTerm: String, page: Int, completion: @escaping (Result<SearchResult>) -> ()) -> AsyncTask?
    @discardableResult func getMovieDetail(imdbID: String, completion: @escaping (Result<MovieDetail>) -> ()) -> AsyncTask?
}

class WebService {
    enum WebServiceError: Error {
        case invalidArguments
    }
    
    private let log = Logger()
    private static var instances = 0
    private let apiClient: ApiClient
    private let baseURL: URL
    private let apiKey: String
    
    init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.apiClient = ApiClient()
        assertSingletonInstance()
    }
    
    private func assertSingletonInstance() {
        #if DEBUG
        // It is allowed and recommended to instantiate multiple instances of this class in UnitTests.
        // In this way we can test the Singelton without the problems of shared state.
        // That's why we do not do this assertion in case of testing.
        // "isUnitTestRunning" is passed as an argument in the Test Profile (in the Xcode build scheme).
        // Arguments passed there are written into UserDefaults, so we can check for them here.
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUnitTestRunning.rawValue) == false {
            WebService.instances += 1
            assert(WebService.instances == 1, "Do not create multiple instances of this class. Get it thru the shared dependencies in your module.")
        }
        #endif
    }
}

extension WebService: WebServiceProtocol {
    @discardableResult func search(searchTerm: String, page: Int, completion: @escaping (Result<SearchResult>) -> ()) -> AsyncTask? {
        var params = [String: String]()
        params["s"] = searchTerm
        params["page"] = String(page)
        params["apikey"] = self.apiKey
        return apiClient.get(url: self.baseURL, params: params, headers: apiClient.defaultHeaders, completion: completion)
    }
    
    @discardableResult func getMovieDetail(imdbID: String, completion: @escaping (Result<MovieDetail>) -> ()) -> AsyncTask? {
        var params = [String: String]()
        params["i"] = imdbID
        params["apikey"] = self.apiKey
        return apiClient.get(url: self.baseURL, params: params, headers: apiClient.defaultHeaders, completion: completion)
    }
}
