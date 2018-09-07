//
//  Result.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

/// Used to hold any type of failable result.
enum Result<Value> {
    case success(Value)
    case failure(Error)
}
