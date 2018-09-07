//
//  BaseViewController.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit

/// Used as base class of every other viewcontroller in the App.
/// Can be used for example to handle background <-> foreground state switches for all viewcontrollers.
class BaseViewController: UIViewController {
    
    // Now every viewcontroller has a log
    var log = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllNotifications()
    }
    
    deinit {
        // Never forget removeObserver anymore.
        // This will ensure that every registration is removed - also in derived viewcontrollers.
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerAllNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func didEnterBackground() {
        // Override this in the derived viewcontroller
    }
    
    @objc func willEnterForeground() {
        // Override this in the derived viewcontroller
    }
}
