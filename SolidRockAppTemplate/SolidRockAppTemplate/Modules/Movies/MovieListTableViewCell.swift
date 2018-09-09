//
//  MovieListTableViewCell.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!

    func configure(presenter: MovieListTableViewCellPresenterProtocol) {
        labelTitle.text = presenter.title
        labelTitle.textColor = presenter.titleColor.value
        labelSubtitle.text = presenter.subtitle
        labelSubtitle.textColor = presenter.subTitleColor.value
    }
}
