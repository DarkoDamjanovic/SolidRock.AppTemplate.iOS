//
//  Font.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation
import UIKit

enum Font {
    case header
    case title
    case subtitle
    case body
    
    var value: UIFont {
        switch self {
        case .header: return UIFont.boldSystemFont(ofSize: 20)
        case .title: return UIFont.boldSystemFont(ofSize: 17)
        case .subtitle: return UIFont.systemFont(ofSize: 14)
        case .body: return UIFont.systemFont(ofSize: 17)
        }
    }
}
