//
//  ModuleTemplateRouter.swift
//  MG2
//
//  Created by Darko Damjanovic on 29.05.18.
//  Copyright © 2018 Marktguru. All rights reserved.
//

import Foundation

protocol ModuleTemplateRouterProtocol {
    
}

/// This is just a template which can be re-used to create other modules.
/// It is not compiled with the project.
class ModuleTemplateRouter {
    private let log = Logger()
    private unowned var view: ModuleTemplateViewController
    private let sharedDependencies: SharedDependenciesProtocol
    
    init(view: ModuleTemplateViewController, sharedDependencies: SharedDependenciesProtocol) {
        self.view = view
        self.sharedDependencies = sharedDependencies
    }
    
    deinit {
        log.info("")
    }
}

extension ModuleTemplateRouter: ModuleTemplateRouterProtocol {
    
}
