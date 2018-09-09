//
//  Color.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation
import UIKit

enum Color {
    case appTintColor
    case tableViewCellTitleColor
    case tableViewCellSubTitleColor
    
    var value: UIColor {
        switch self {
        case .appTintColor: return UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1.0)
        case .tableViewCellTitleColor: return UIColor.black
        case .tableViewCellSubTitleColor: return UIColor.darkGray
        }
    }
}
