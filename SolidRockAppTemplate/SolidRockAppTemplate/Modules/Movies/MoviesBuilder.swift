//
//  MoviesBuilder.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

class MoviesBuilder {
    private let log = Logger()
    private let sharedDependencies: SharedDependenciesProtocol
    
    init(sharedDependencies: SharedDependenciesProtocol) {
        self.sharedDependencies = sharedDependencies
    }
    
    func build() -> MoviesViewController {
        let view = MoviesViewController.storyboardInstance()
        let router = MoviesRouter(view: view, sharedDependencies: sharedDependencies)
        let presenter = MoviesPresenter(view: view, router: router, webService: sharedDependencies.webService)
        view.presenter = presenter
        return view
    }
    
    deinit {
        log.info("")
    }
}
