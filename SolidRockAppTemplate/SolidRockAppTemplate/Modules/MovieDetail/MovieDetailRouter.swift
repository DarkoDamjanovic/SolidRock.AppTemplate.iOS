//
//  MovieDetailRouter.swift
//  MG2
//
//  Created by Darko Damjanovic on 29.05.18.
//  Copyright © 2018 Marktguru. All rights reserved.
//

import Foundation

protocol MovieDetailRouterProtocol {
    
}

/// This is just a template which can be re-used to create other modules.
/// It is not compiled with the project.
class MovieDetailRouter {
    private let log = Logger()
    private unowned var view: MovieDetailViewController
    private let sharedDependencies: SharedDependenciesProtocol
    
    init(view: MovieDetailViewController, sharedDependencies: SharedDependenciesProtocol) {
        self.view = view
        self.sharedDependencies = sharedDependencies
    }
    
    deinit {
        log.info("")
    }
}

extension MovieDetailRouter: MovieDetailRouterProtocol {
    
}
