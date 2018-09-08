//
//  ModuleTemplateBuilder.swift
//  MG2
//
//  Created by Darko Damjanovic on 29.05.18.
//  Copyright © 2018 Marktguru. All rights reserved.
//

import Foundation

/// This is just a template which can be re-used to create other modules.
/// It is not compiled with the project.
class ModuleTemplateBuilder {
    private let log = Logger()
    private let sharedDependencies: SharedDependenciesProtocol
    
    init(sharedDependencies: SharedDependenciesProtocol) {
        self.sharedDependencies = sharedDependencies
    }
    
    func build() -> ModuleTemplateViewController {
        let view = ModuleTemplateViewController.storyboardInstance()
        let router = ModuleTemplateRouter(view: view, sharedDependencies: sharedDependencies)
        let presenter = ModuleTemplatePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    deinit {
        log.info("")
    }
}
