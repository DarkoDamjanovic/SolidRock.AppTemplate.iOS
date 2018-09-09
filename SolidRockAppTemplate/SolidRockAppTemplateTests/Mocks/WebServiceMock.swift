//
//  WebServiceMock.swift
//  SolidRockAppTemplateTests
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation
@testable import SolidRockAppTemplate

class WebServiceMock: WebServiceProtocol {
    enum WebServiceMockError: Error {
        case mockError
    }
    
    var searchResult: SearchResult?
    var movieDetail: MovieDetail?
    
    func search(searchTerm: String, page: Int, completion: @escaping (Result<SearchResult>) -> ()) -> AsyncTask? {
        if let searchResult = self.searchResult {
            completion(Result.success(searchResult))
        } else {
            completion(Result.failure(WebServiceMockError.mockError))
        }
        return nil
    }
    
    func getMovieDetail(imdbID: String, completion: @escaping (Result<MovieDetail>) -> ()) -> AsyncTask? {
        if let movieDetail = self.movieDetail {
            completion(Result.success(movieDetail))
        } else {
            completion(Result.failure(WebServiceMockError.mockError))
        }
        return nil
    }
}
