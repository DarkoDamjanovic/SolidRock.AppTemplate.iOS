//
//  MovieListTableViewCellPresenter.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

protocol MovieListTableViewCellPresenterProtocol {
    var title: String { get }
    var subtitle: String { get }
    var titleColor: Color { get }
    var subTitleColor: Color { get }
}

class MovieListTableViewCellPresenter: MovieListTableViewCellPresenterProtocol {
    let title: String
    let subtitle: String
    let titleColor = Color.tableViewCellTitleColor
    let subTitleColor = Color.tableViewCellSubTitleColor
    
    init(movie: Movie) {
        title = movie.title
        subtitle = movie.year
    }
}
