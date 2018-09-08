//
//  MoviesPresenter.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol MoviesPresenterProtocol {
    func viewDidAppear()
    var movies: [Movie] { get }
    var searchTerm: String { get set }
    func didSelectRowAt(indexPath: IndexPath)
}

class MoviesPresenter {
    private let log = Logger()
    private unowned let view: MoviesViewProtocol
    private let router: MoviesRouterProtocol
    private let webService: WebServiceProtocol

    private(set) var movies = [Movie]()
    
    // Initial search is Batman (hardcoded, not nice, just for demonstration)
    var searchTerm = "Batman"
    
    init(view: MoviesViewProtocol, router: MoviesRouterProtocol, webService: WebServiceProtocol) {
        self.view = view
        self.router = router
        self.webService = webService
    }
    
    deinit {
        log.info("")
    }
}

extension MoviesPresenter: MoviesPresenterProtocol {
    func viewDidAppear() {
        webService.getSearchResult(searchTerm: self.searchTerm, page: 1) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let searchResult):
                strongSelf.movies = searchResult.movies
                strongSelf.view.reloadDataSource()
            case .failure(let error):
                // TODO: error handling
                strongSelf.log.error(error)
            }
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        view.deselectRowAt(indexPath: indexPath, animated: true)
    }
}




