//
//  ModuleTemplateViewController.swift
//  MG2
//
//  Created by Darko Damjanovic on 24.05.18.
//  Copyright © 2018 Marktguru. All rights reserved.
//

import Foundation

protocol ModuleTemplateViewProtocol: class {

}

/// This is just a template which can be re-used to create other modules.
/// It is not compiled with the project.
class ModuleTemplateViewController: BaseViewController {

    var presenter: ModuleTemplatePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    deinit {
        log.info("")
    }
}

extension ModuleTemplateViewController: ModuleTemplateViewProtocol {

}
