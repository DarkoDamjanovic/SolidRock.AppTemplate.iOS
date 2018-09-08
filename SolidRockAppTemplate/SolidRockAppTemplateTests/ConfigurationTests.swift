//
//  ConfigurationTests.swift
//  SolidRockAppTemplateTests
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import XCTest
@testable import SolidRockAppTemplate

class ConfigurationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBaseURL() {
        let config = Configuration()
        XCTAssert(config.baseURL.absoluteString == "http://www.omdbapi.com")
    }
    
    func testApiKey() {
        let config = Configuration()
        XCTAssert(config.apiKey == "1a9bf897")
    }
}
