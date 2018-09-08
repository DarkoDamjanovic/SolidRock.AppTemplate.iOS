//
//  WebService.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol WebServiceProtocol {
    @discardableResult func getSearchResult(searchTerm: String, page: Int, completion: @escaping (Result<SearchResult>) -> ()) -> AsyncNetworkTask?
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
    
    @discardableResult func getSearchResult(searchTerm: String, page: Int, completion: @escaping (Result<SearchResult>) -> ()) -> AsyncNetworkTask? {
        var params = [String: String]()
        params["s"] = searchTerm
        params["page"] = String(page)
        params["apikey"] = self.apiKey
        return apiClient.get(url: self.baseURL, params: params, headers: apiClient.defaultHeaders, completion: completion)
    }
}
