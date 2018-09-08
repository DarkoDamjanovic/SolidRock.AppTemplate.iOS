//
//  Configuration.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol ConfigurationProtocol {
    var baseURL: URL { get }
}

class Configuration: Codable, ConfigurationProtocol {
    let baseURL: URL
    
    init() {
        // Use ! here extensively because if the config is wrong we want to fail early
        let url = Bundle.main.infoDictionary!["BaseURL"] as! String
        baseURL = URL(string: url)!
        let log = Logger()
        log.info("Config loaded:")
        log.info("baseURL: \(self.baseURL.absoluteString)")
    }
}

