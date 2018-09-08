//
//  Singleton.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

/// This is used to assure that there is only one instance of a class.
/// It assures a Singelton but without the problematic global access.
/// Use this as a base class for every class which should only be instantiated once.
class Singleton {
    private static var instances = 0
    
    required init() {
        assertSingletonInstance()
    }
    
    private func assertSingletonInstance() {
        #if DEBUG
            /// It is allowed and recommended to instantiate multiple instances of this class in UnitTests.
            // That's why we do not do this assertion in case of testing.
            #if !TEST
                Singleton.instances += 1
                assert(Singleton.instances == 1, "Do not create multiple instances of this class. Get it thru the shared dependencies in your module.")
            #endif
        #endif
    }
}   