//
//  ConfigurationMock.swift
//  SolidRockAppTemplateTests
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation
@testable import SolidRockAppTemplate

class ConfigurationMock: ConfigurationProtocol {
    var baseURL: URL = URL(string: "mock.com")!
    var apiKey: String = "Mock Api Key"
}
