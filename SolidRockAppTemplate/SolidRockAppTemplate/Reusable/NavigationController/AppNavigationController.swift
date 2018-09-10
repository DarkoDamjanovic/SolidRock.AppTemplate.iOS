//
//  AppNavigationController.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit

/// In most Apps always the same style of NavigationController is used.
/// To assure that the same style is used everywhere - use mostly this one.
/// Just create another one if you have a specific usecase which can't be handled by this class.
class AppNavigationController: UINavigationController {
    
    private let log = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.navigationBar.tintColor = Color.appTintColor.rawValue
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : Color.appTintColor.rawValue]
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : Color.appTintColor.rawValue]
    }
}
