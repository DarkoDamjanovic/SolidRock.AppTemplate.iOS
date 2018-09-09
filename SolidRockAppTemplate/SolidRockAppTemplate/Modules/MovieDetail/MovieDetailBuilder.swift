//
//  MovieDetailBuilder.swift
//  MG2
//
//  Created by Darko Damjanovic on 29.05.18.
//  Copyright © 2018 Marktguru. All rights reserved.
//

import Foundation

class MovieDetailBuilder {
    private let log = Logger()
    private let sharedDependencies: SharedDependenciesProtocol
    private let imdbID: String
    
    init(sharedDependencies: SharedDependenciesProtocol, imdbID: String) {
        self.sharedDependencies = sharedDependencies
        self.imdbID = imdbID
    }
    
    func build() -> MovieDetailViewController {
        let view = MovieDetailViewController.storyboardInstance()
        let router = MovieDetailRouter(view: view, sharedDependencies: sharedDependencies)
        let movieService = MovieService(webService: sharedDependencies.webService)
        let presenter = MovieDetailPresenter(view: view, router: router, imdbID: imdbID, movieService: movieService)
        view.presenter = presenter
        return view
    }
    
    deinit {
        log.info("")
    }
}
