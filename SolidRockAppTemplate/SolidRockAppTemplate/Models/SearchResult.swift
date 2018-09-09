//
//  SearchResult.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let movies: [Movie]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
    
    /// This initializer is used only for testing
    init(movies: [Movie], totalResults: String, response: String) {
        self.movies = movies
        self.totalResults = totalResults
        self.response = response
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decode([Movie].self, forKey: .movies)
        totalResults = try values.decode(String.self, forKey: .totalResults)
        response = try values.decode(String.self, forKey: .response)
    }
}
