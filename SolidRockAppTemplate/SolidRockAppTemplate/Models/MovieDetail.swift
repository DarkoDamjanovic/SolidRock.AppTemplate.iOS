//
//  MovieDetail.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let title: String?
    let year: String?
    let imdbId: String?
    let image: URL?
    let writer: String?
    let actors: String?
    let plot: String?
    let director: String?
    let genre: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case image = "Poster"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case director = "Director"
        case genre = "Genre"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        imdbId = try values.decodeIfPresent(String.self, forKey: .imdbId)
        image = try values.decodeIfPresent(URL.self, forKey: .image)
        writer = try values.decodeIfPresent(String.self, forKey: .writer)
        actors = try values.decodeIfPresent(String.self, forKey: .actors)
        plot = try values.decodeIfPresent(String.self, forKey: .plot)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        genre = try values.decodeIfPresent(String.self, forKey: .genre)
    }
}
