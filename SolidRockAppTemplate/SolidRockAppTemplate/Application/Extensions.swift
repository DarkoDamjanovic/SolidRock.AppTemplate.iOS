//
//  Extensions.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func storyboardInstance() -> Self {
        let bundle = Bundle(for: self)
        let storyboardName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.initialViewController()
    }
}

extension UIStoryboard {
    func initialViewController<T: UIViewController>() -> T {
        return self.instantiateInitialViewController() as! T
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

