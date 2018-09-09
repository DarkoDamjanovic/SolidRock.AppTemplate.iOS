//
//  MovieService.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol {
    @discardableResult func searchMovies(searchTerm: String, page: Int, completion: @escaping (Result<[Movie]>) -> ()) -> AsyncTask?
    @discardableResult func getMovieDetail(imdbID: String, completion: @escaping (Result<MovieDetail>) -> ()) -> AsyncTask?
}

class MovieService {
    private let log = Logger()
    private let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
}

extension MovieService: MovieServiceProtocol {
    @discardableResult func searchMovies(searchTerm: String, page: Int, completion: @escaping (Result<[Movie]>) -> ()) -> AsyncTask? {
        return webService.search(searchTerm: searchTerm, page: 1) { (result) in
            switch result {
            case .success(let searchResult):
                let movies = searchResult.movies.filter { $0.type == .movie }
                completion(Result.success(movies))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    @discardableResult func getMovieDetail(imdbID: String, completion: @escaping (Result<MovieDetail>) -> ()) -> AsyncTask? {
        return webService.getMovieDetail(imdbID: imdbID, completion: completion)
    }
}
