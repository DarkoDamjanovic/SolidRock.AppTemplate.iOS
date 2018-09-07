//
//  NotificationNames.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

/// Specify all App Notifications here.
/// ### Usage Example: ###
/// ````
/// NotificationCenter.default.post(name: Notifications.testNotification.name, object: nil)
/// ````
enum Notifications: String, NotificationName {
    // By using an enum the compiler checks for uniqueness.
    case testNotification
    case anotherTestNotification
}

protocol NotificationName {
    var name: Notification.Name { get }
}

/// Removes the need to name every single Notification apart from their raw value itself.
extension RawRepresentable where RawValue == String, Self: NotificationName {
    var name: Notification.Name {
        get {
            return Notification.Name(self.rawValue)
        }
    }
}
