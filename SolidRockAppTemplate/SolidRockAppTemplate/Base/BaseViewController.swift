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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerAllNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    @objc func didEnterBackground() {
        
    }
    
    @objc func willEnterForeground() {
        
    }
}
