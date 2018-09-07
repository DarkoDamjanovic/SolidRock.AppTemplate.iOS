//
//  AppDelegate.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let log = Logger()

    /// This is the very first entry point of the App.
    /// It is called even before didFinishLaunchingWithOptions.
    override init() {
        super.init()
        // Do any needed App initialization here.
        
        // This is the place where UserDefault values should be initialized.
        var initialDefaults = [String: AnyObject]()
        initialDefaults[UserDefaultsKeys.userDefaultsInitialized.rawValue] = true as AnyObject?
        UserDefaults.standard.register(defaults: initialDefaults)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        launchUI()
        return true
    }

    /// Launch the UI by any means programatically.
    /// This gives us the chance to inject the root dependencies.
    private func launchUI() {
//        let builder = InitializationBuilder(sharedDependencies: sharedDependencies)
        let viewController = MoviesViewController.storyboardInstance()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = viewController
        self.window!.makeKeyAndVisible()
    }
}



