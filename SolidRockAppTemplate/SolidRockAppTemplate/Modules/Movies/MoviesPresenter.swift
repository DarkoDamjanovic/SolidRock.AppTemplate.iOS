//
//  MoviesPresenter.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol MoviesPresenterProtocol {

}

class MoviesPresenter {
    private let log = Logger()
    private unowned let view: MoviesViewProtocol
    private let router: MoviesRouterProtocol

    
    init(view: MoviesViewProtocol, router: MoviesRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    deinit {
        log.info("")
    }
}

extension MoviesPresenter: MoviesPresenterProtocol {

}
