//
//  MovieServiceMock.swift
//  SolidRockAppTemplateTests
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation
@testable import SolidRockAppTemplate

class MovieServiceMock: MovieServiceProtocol {
    enum MovieServiceMockError: Error {
        case mockError
    }
    
    var movies: [Movie]?
    var movieDetail: MovieDetail?
    
    func searchMovies(searchTerm: String, page: Int, completion: @escaping (Result<[Movie]>) -> ()) -> AsyncTask? {
        if let movies = self.movies {
            completion(Result.success(movies))
        } else {
            completion(Result.failure(MovieServiceMockError.mockError))
        }
        return nil
    }
    
    func getMovieDetail(imdbID: String, completion: @escaping (Result<MovieDetail>) -> ()) -> AsyncTask? {
        if let movieDetail = self.movieDetail {
            completion(Result.success(movieDetail))
        } else {
            completion(Result.failure(MovieServiceMockError.mockError))
        }
        return nil
    }
}
