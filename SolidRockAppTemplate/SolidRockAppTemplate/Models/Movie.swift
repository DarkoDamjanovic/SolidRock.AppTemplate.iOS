//
//  Movie.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

struct Movie: Codable {
    enum MovieType: String, Codable {
        case movie
        case series
        case episode
    }
    
    let title: String
    let year: String
    let type: MovieType
    let imdbId: String
    let image: URL
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case imdbId = "imdbID"
        case image = "Poster"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        year = try values.decode(String.self, forKey: .year)
        type = try values.decode(Movie.MovieType.self, forKey: .type)
        imdbId = try values.decode(String.self, forKey: .imdbId)
        image = try values.decode(URL.self, forKey: .image)
    }
}
