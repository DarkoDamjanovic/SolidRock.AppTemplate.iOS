//
//  SharedDependencies.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol SharedDependenciesProtocol {
    var configuration: ConfigurationProtocol { get }
    var webService: WebServiceProtocol { get }
}

/// Holds all shared dependencies for the Application.
// The Swift lazy feature is used here to create a correct dependency injection tree.
// It doesn't matter which dependency is loaded first, it will automatically create all it's needed dependencies here and they will be injected.
class SharedDependencies: SharedDependenciesProtocol {
    lazy var configuration: ConfigurationProtocol = Configuration()
    lazy var webService: WebServiceProtocol = WebService(baseURL: self.configuration.baseURL, apiKey: self.configuration.apiKey)
}


