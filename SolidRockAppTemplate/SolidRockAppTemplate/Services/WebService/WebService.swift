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

class WebService: WebServiceProtocol {
    enum WebServiceError: Error {
        case invalidArguments
    }
    
    private let log = Logger()
    private let apiClient: ApiClient
    private let baseURL: URL
    private let apiKey: String
    
    init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.apiClient = ApiClient()
    }
    
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
