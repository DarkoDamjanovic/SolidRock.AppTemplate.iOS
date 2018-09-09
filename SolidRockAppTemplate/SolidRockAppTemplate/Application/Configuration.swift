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
class Configuration: ConfigurationProtocol {
    let baseURL: URL
    let apiKey: String
    private let log = Logger()
    private static var instances = 0
    
    init() {
        // Use ! here extensively because if the config is wrong we want to fail early
        let url = Bundle.main.infoDictionary!["BaseURL"] as! String
        baseURL = URL(string: url)!
        self.apiKey = Bundle.main.infoDictionary!["ApiKey"] as! String
        log.info("Config successfully loaded")
        log.info("baseURL: \(self.baseURL.absoluteString)")
        log.debug("ApiKey: \(self.apiKey)")
        
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
            Configuration.instances += 1
            assert(Configuration.instances == 1, "Do not create multiple instances of this class. Get it thru the shared dependencies in your module.")
        }
        #endif
    }
}

