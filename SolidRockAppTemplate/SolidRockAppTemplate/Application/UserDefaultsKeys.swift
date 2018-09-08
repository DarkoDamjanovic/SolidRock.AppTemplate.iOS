//
//  UserDefaultsKeys.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

/// Declares all user defaults keys of the App.
/// ### Usage Example: ###
/// ````
/// let boolValue = UserDefaults.standard.bool(forKey: UserDefaultsKeys.userDefaultsInitialized.rawValue)
/// ````
enum UserDefaultsKeys: String {
    // Do not change or remove this keys as it will break backwards compatibility. Just add new ones as needed.
    // By declaring this as enum the compiler checks for uniqueness.
    case userDefaultsInitialized
    case isUnitTestRunning
}

