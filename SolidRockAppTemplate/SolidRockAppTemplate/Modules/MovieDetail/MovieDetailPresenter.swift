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
    var titleFont: Font { get }
    var titleColor: Color { get }
    var year: String? { get }
    var yearFont: Font { get }
    var yearColor: Color { get }
    var director: String? { get }
    var directorFont: Font { get }
    var directorColor: Color { get }
    var genre: String? { get }
    var genreFont: Font { get }
    var genreColor: Color { get }
    var actors: String? { get }
    var actorsFont: Font { get }
    var actorsColor: Color { get }
    var plot: String? { get }
    var plotFont: Font { get }
    var plotColor: Color { get }
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
    
    var titleFont: Font {
        return Font.header
    }
    
    var titleColor: Color {
        return Color.title
    }
    
    var year: String? {
        return movieDetail?.year
    }
    
    var yearFont: Font {
        return Font.title
    }
    
    var yearColor: Color {
        return Color.subtitle
    }
    
    var director: String? {
        return movieDetail?.director
    }
    
    var directorFont: Font {
        return Font.title
    }
    
    var directorColor: Color {
        return Color.title
    }
    
    var genre: String? {
        return movieDetail?.genre
    }
    
    var genreFont: Font {
        return Font.body
    }
    
    var genreColor: Color {
        return Color.subtitle
    }
    
    var actors: String? {
        return movieDetail?.actors
    }
    
    var actorsFont: Font {
        return Font.title
    }
    
    var actorsColor: Color {
        return Color.title
    }
    
    var plot: String? {
        return movieDetail?.plot
    }
    
    var plotFont: Font {
        return Font.body
    }
    
    var plotColor: Color {
        return Color.subtitle
    }
    
    var imagePosterURL: URL? {
        return movieDetail?.image
    }
    
    func viewDidAppear() {
        view.viewState = .loading
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
            strongSelf.view.viewState = .presenting
        }
    }
}

