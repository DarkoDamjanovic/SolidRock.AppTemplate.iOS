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
    var numberOfRows: Int { get }
    var viewTitle: String { get }
    func didSelectRowAt(indexPath: IndexPath)
    func presenterForRowAt(indexPath: IndexPath) -> MovieListTableViewCellPresenterProtocol?
}

class MoviesPresenter {
    private let log = Logger()
    private unowned let view: MoviesViewProtocol
    private let router: MoviesRouterProtocol
    private let movieService: MovieServiceProtocol

    private(set) var movies = [Movie]()
    
    // Initial search is Batman (hardcoded, not nice, just for demonstration)
    var searchTerm = "Batman"
    
    init(view: MoviesViewProtocol, router: MoviesRouterProtocol, movieService: MovieServiceProtocol) {
        self.view = view
        self.router = router
        self.movieService = movieService
    }
    
    deinit {
        log.info("")
    }
}

extension MoviesPresenter: MoviesPresenterProtocol {
    var viewTitle: String {
        return "movies.title".localized
    }
    
    var numberOfRows: Int {
        return movies.count
    }
    
    func viewDidAppear() {
        movieService.searchMovies(searchTerm: self.searchTerm, page: 1) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movies):
                strongSelf.movies = movies
                strongSelf.view.reloadDataSource()
            case .failure(let error):
                // TODO: error handling
                strongSelf.log.error(error)
            }
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        view.deselectRowAt(indexPath: indexPath, animated: true)
        if movies.indices.contains(indexPath.row) {
            let movie = movies[indexPath.row]
            router.navigateToMovieDetail(imdbID: movie.imdbId)
        }
    }
    
    func presenterForRowAt(indexPath: IndexPath) -> MovieListTableViewCellPresenterProtocol? {
        if movies.indices.contains(indexPath.row) {
            return MovieListTableViewCellPresenter(movie: movies[indexPath.row])
        } else {
            return nil
        }
    }
}




