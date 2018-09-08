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
    let totalResults: Int
    let reponse: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults = "totalResults"
        case reponse = "Response"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decode([Movie].self, forKey: .movies)
        totalResults = try values.decode(Int.self, forKey: .totalResults)
        reponse = try values.decode(String.self, forKey: .reponse)
    }
}
