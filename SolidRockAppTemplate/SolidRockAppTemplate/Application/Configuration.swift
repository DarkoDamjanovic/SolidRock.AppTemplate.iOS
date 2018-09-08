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
    var apiKey: String { get }
}

/// Holds all the App configuration loaded from the Info.plist.
class Configuration: Singleton, ConfigurationProtocol {
    let baseURL: URL
    let apiKey: String
    private let log = Logger()
    
    required init() {
        // Use ! here extensively because if the config is wrong we want to fail early
        let url = Bundle.main.infoDictionary!["BaseURL"] as! String
        baseURL = URL(string: url)!
        self.apiKey = Bundle.main.infoDictionary!["ApiKey"] as! String
        
        super.init()
        
        log.info("Config successfully loaded")
        log.info("baseURL: \(self.baseURL.absoluteString)")
        log.debug("ApiKey: \(self.apiKey)")
    }

}

