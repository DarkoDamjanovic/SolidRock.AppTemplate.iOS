//
//  WebService.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol WebServiceProtocol {
    
}

class WebService: WebServiceProtocol {
    private let log = Logger()
    private let apiClient: ApiClient
    
    init(baseURL: URL) {
        self.apiClient = ApiClient(baseURL: baseURL)
    }
}
