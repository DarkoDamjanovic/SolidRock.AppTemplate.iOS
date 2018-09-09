//
//  MoviesPresenterTests.swift
//  SolidRockAppTemplateTests
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import XCTest
@testable import SolidRockAppTemplate

class MoviesPresenterTests: XCTestCase {

    class MoviesViewMock: MoviesViewProtocol {
        var reloadDataSourceCalled = false
        func reloadDataSource() {
            self.reloadDataSourceCalled = true
        }
        
        var deselectRowAtIndexPath: IndexPath?
        var deselectRowAtAnimated: Bool?
        func deselectRowAt(indexPath: IndexPath, animated: Bool) {
            self.deselectRowAtIndexPath = indexPath
            self.deselectRowAtAnimated = animated
        }
    }
    
    class MoviesRouterMock: MoviesRouterProtocol {
        var navigateToMovieDetailImdbID: String?
        func navigateToMovieDetail(imdbID: String) {
            navigateToMovieDetailImdbID = imdbID
        }
    }
    
    func testViewTitle() {
        let view = MoviesViewMock()
        let router = MoviesRouterMock()
        let movieService = MovieServiceMock()
        var movies = [Movie]()
        let movie1 = Movie(title: "Title1", year: "Year1", type: .movie, imdbId: "imdbId1", image: URL(string: "http://mockimage1.com")!)
        let movie2 = Movie(title: "Title2", year: "Year2", type: .movie, imdbId: "imdbId2", image: URL(string: "http://mockimage2.com")!)
        let movie3 = Movie(title: "Title3", year: "Year3", type: .movie, imdbId: "imdbId3", image: URL(string: "http://mockimage3.com")!)
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movieService.movies = movies
        let presenter = MoviesPresenter(view: view, router: router, movieService: movieService)
        XCTAssert(presenter.viewTitle == "Movies")
    }
    
    func testNumberOfRows() {
        let view = MoviesViewMock()
        let router = MoviesRouterMock()
        let movieService = MovieServiceMock()
        var movies = [Movie]()
        let movie1 = Movie(title: "Title1", year: "Year1", type: .movie, imdbId: "imdbId1", image: URL(string: "http://mockimage1.com")!)
        let movie2 = Movie(title: "Title2", year: "Year2", type: .movie, imdbId: "imdbId2", image: URL(string: "http://mockimage2.com")!)
        let movie3 = Movie(title: "Title3", year: "Year3", type: .movie, imdbId: "imdbId3", image: URL(string: "http://mockimage3.com")!)
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movieService.movies = movies
        let presenter = MoviesPresenter(view: view, router: router, movieService: movieService)
        presenter.viewDidAppear()
        XCTAssert(presenter.numberOfRows == 3)
        XCTAssertEqual(presenter.movies[0].title, "Title1")
        XCTAssertEqual(presenter.movies[1].title, "Title2")
        XCTAssertEqual(presenter.movies[2].title, "Title3")
    }
    
    func testViewDidAppearSuccess() {
        let view = MoviesViewMock()
        let router = MoviesRouterMock()
        let movieService = MovieServiceMock()
        var movies = [Movie]()
        let movie1 = Movie(title: "Title1", year: "Year1", type: .movie, imdbId: "imdbId1", image: URL(string: "http://mockimage1.com")!)
        let movie2 = Movie(title: "Title2", year: "Year2", type: .movie, imdbId: "imdbId2", image: URL(string: "http://mockimage2.com")!)
        let movie3 = Movie(title: "Title3", year: "Year3", type: .movie, imdbId: "imdbId3", image: URL(string: "http://mockimage3.com")!)
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movieService.movies = movies
        let presenter = MoviesPresenter(view: view, router: router, movieService: movieService)
        presenter.viewDidAppear()
        XCTAssert(view.reloadDataSourceCalled == true)
    }
    
    func testViewDidAppearError() {
        let view = MoviesViewMock()
        let router = MoviesRouterMock()
        let movieService = MovieServiceMock()
        var movies = [Movie]()
        let movie1 = Movie(title: "Title1", year: "Year1", type: .movie, imdbId: "imdbId1", image: URL(string: "http://mockimage1.com")!)
        let movie2 = Movie(title: "Title2", year: "Year2", type: .movie, imdbId: "imdbId2", image: URL(string: "http://mockimage2.com")!)
        let movie3 = Movie(title: "Title3", year: "Year3", type: .movie, imdbId: "imdbId3", image: URL(string: "http://mockimage3.com")!)
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        //movieService.movies = movies // not set, leads to an error in the MovieServiceMock
        let presenter = MoviesPresenter(view: view, router: router, movieService: movieService)
        presenter.viewDidAppear()
        XCTAssert(view.reloadDataSourceCalled == false)
    }
    
    func testViewDidSelectRow() {
        let view = MoviesViewMock()
        let router = MoviesRouterMock()
        let movieService = MovieServiceMock()
        var movies = [Movie]()
        let movie1 = Movie(title: "Title1", year: "Year1", type: .movie, imdbId: "imdbId1", image: URL(string: "http://mockimage1.com")!)
        let movie2 = Movie(title: "Title2", year: "Year2", type: .movie, imdbId: "imdbId2", image: URL(string: "http://mockimage2.com")!)
        let movie3 = Movie(title: "Title3", year: "Year3", type: .movie, imdbId: "imdbId3", image: URL(string: "http://mockimage3.com")!)
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movieService.movies = movies
        let presenter = MoviesPresenter(view: view, router: router, movieService: movieService)
        presenter.viewDidAppear()
        presenter.didSelectRowAt(indexPath: IndexPath(row: 2, section: 8))
        XCTAssertNotNil(view.deselectRowAtIndexPath)
        if let mockedIndexPath = view.deselectRowAtIndexPath {
            XCTAssert(mockedIndexPath.row == 2)
            XCTAssert(mockedIndexPath.section == 8)
        }
        XCTAssertNotNil(router.navigateToMovieDetailImdbID)
        if let imdbID = router.navigateToMovieDetailImdbID {
            XCTAssertEqual(imdbID, "imdbId3")
        }
    }
    
    func testPresenterForRowAtSuccess() {
        let view = MoviesViewMock()
        let router = MoviesRouterMock()
        let movieService = MovieServiceMock()
        var movies = [Movie]()
        let movie1 = Movie(title: "Title1", year: "Year1", type: .movie, imdbId: "imdbId1", image: URL(string: "http://mockimage1.com")!)
        let movie2 = Movie(title: "Title2", year: "Year2", type: .movie, imdbId: "imdbId2", image: URL(string: "http://mockimage2.com")!)
        let movie3 = Movie(title: "Title3", year: "Year3", type: .movie, imdbId: "imdbId3", image: URL(string: "http://mockimage3.com")!)
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movieService.movies = movies
        let presenter = MoviesPresenter(view: view, router: router, movieService: movieService)
        presenter.viewDidAppear()
        let cellPresenter = presenter.presenterForRowAt(indexPath: IndexPath(row: 2, section: 8))
        XCTAssertNotNil(cellPresenter)
        if let cellPresenter = cellPresenter {
            XCTAssertEqual(cellPresenter.title, "Title3")
        }
    }
    
    func testPresenterForRowAtFailure() {
        let view = MoviesViewMock()
        let router = MoviesRouterMock()
        let movieService = MovieServiceMock()
        var movies = [Movie]()
        let movie1 = Movie(title: "Title1", year: "Year1", type: .movie, imdbId: "imdbId1", image: URL(string: "http://mockimage1.com")!)
        let movie2 = Movie(title: "Title2", year: "Year2", type: .movie, imdbId: "imdbId2", image: URL(string: "http://mockimage2.com")!)
        let movie3 = Movie(title: "Title3", year: "Year3", type: .movie, imdbId: "imdbId3", image: URL(string: "http://mockimage3.com")!)
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movieService.movies = movies
        let presenter = MoviesPresenter(view: view, router: router, movieService: movieService)
        presenter.viewDidAppear()
        let cellPresenter = presenter.presenterForRowAt(indexPath: IndexPath(row: 4, section: 8))
        XCTAssertNil(cellPresenter)
    }
}
