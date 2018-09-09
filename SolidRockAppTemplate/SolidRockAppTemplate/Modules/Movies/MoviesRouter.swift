//
//  MoviesRouter.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol MoviesRouterProtocol {
    func navigateToMovieDetail(imdbID: String)
}

class MoviesRouter {
    private let log = Logger()
    private unowned var view: MoviesViewController
    private let sharedDependencies: SharedDependenciesProtocol
    
    init(view: MoviesViewController, sharedDependencies: SharedDependenciesProtocol) {
        self.view = view
        self.sharedDependencies = sharedDependencies
    }
    
    deinit {
        log.info("")
    }
}

extension MoviesRouter: MoviesRouterProtocol {
    func navigateToMovieDetail(imdbID: String) {
        let builder = MovieDetailBuilder(sharedDependencies: sharedDependencies, imdbID: imdbID)
        let viewController = builder.build()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
