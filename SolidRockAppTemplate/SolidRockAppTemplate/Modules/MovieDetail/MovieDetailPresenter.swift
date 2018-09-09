//
//  MovieDetailPresenter.swift
//  MG2
//
//  Created by Darko Damjanovic on 29.05.18.
//  Copyright © 2018 Marktguru. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    var viewTitle: String { get }
}

/// This is just a template which can be re-used to create other modules.
/// It is not compiled with the project.
class MovieDetailPresenter {
    private let log = Logger()
    private unowned let view: MovieDetailViewProtocol
    private let router: MovieDetailRouterProtocol
    private let imdbID: String
    
    init(view: MovieDetailViewProtocol,
         router: MovieDetailRouterProtocol,
         imdbID: String,
         movieService: MovieServiceProtocol) {
        self.view = view
        self.router = router
        self.imdbID = imdbID
    }
    
    deinit {
        log.info("")
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    var viewTitle: String {
        return "moviedetail.title".localized
    }
}

