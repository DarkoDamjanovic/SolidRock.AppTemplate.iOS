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
    var title: String? { get }
    var year: String? { get }
    var director: String? { get }
    var genre: String? { get }
    var actors: String? { get }
    var plot: String? { get }
    var imagePosterURL: URL? { get }
    func viewDidAppear()
}

/// This is just a template which can be re-used to create other modules.
/// It is not compiled with the project.
class MovieDetailPresenter {
    private let log = Logger()
    private unowned let view: MovieDetailViewProtocol
    private let router: MovieDetailRouterProtocol
    private let imdbID: String
    private let movieService: MovieServiceProtocol
    private var movieDetail: MovieDetail?
    
    init(view: MovieDetailViewProtocol,
         router: MovieDetailRouterProtocol,
         imdbID: String,
         movieService: MovieServiceProtocol) {
        self.view = view
        self.router = router
        self.imdbID = imdbID
        self.movieService = movieService
    }
    
    deinit {
        log.info("")
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    var viewTitle: String {
        return "moviedetail.title".localized
    }
    
    var title: String? {
        return movieDetail?.title
    }
    
    var year: String? {
        return movieDetail?.year
    }
    
    var director: String? {
        return movieDetail?.director
    }
    
    var genre: String? {
        return movieDetail?.genre
    }
    
    var actors: String? {
        return movieDetail?.actors
    }
    
    var plot: String? {
        return movieDetail?.plot
    }
    
    var imagePosterURL: URL? {
        return movieDetail?.image
    }
    
    func viewDidAppear() {
        movieService.getMovieDetail(imdbID: imdbID) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let movieDetail):
                strongSelf.movieDetail = movieDetail
                strongSelf.view.loadUI()
            case .failure(let error):
                // TODO: error handling
                strongSelf.log.error(error)
            }
        }
    }
}

