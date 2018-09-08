//
//  ModuleTemplatePresenter.swift
//  MG2
//
//  Created by Darko Damjanovic on 29.05.18.
//  Copyright © 2018 Marktguru. All rights reserved.
//

import Foundation

protocol ModuleTemplatePresenterProtocol {

}

/// This is just a template which can be re-used to create other modules.
/// It is not compiled with the project.
class ModuleTemplatePresenter {
    private let log = Logger()
    private unowned let view: ModuleTemplateViewProtocol
    private let router: ModuleTemplateRouterProtocol
    
    init(view: ModuleTemplateViewProtocol, router: ModuleTemplateRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    deinit {
        log.info("")
    }
}

extension ModuleTemplatePresenter: ModuleTemplatePresenterProtocol {

}

