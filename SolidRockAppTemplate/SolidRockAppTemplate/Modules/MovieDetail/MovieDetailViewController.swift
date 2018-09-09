//
//  MovieDetailViewController.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit
import SDWebImage

protocol MovieDetailViewProtocol: class {
    func loadUI()
}

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelDirector: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelActors: UILabel!
    @IBOutlet weak var labelPlot: UILabel!
    
    var presenter: MovieDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = presenter.viewTitle
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func loadUI() {
        imageViewPoster.sd_setImage(with: presenter.imagePosterURL, completed: nil)
        labelTitle.text = presenter.title
        labelYear.text = presenter.year
        labelGenre.text = presenter.genre
        labelDirector.text = presenter.director
        labelActors.text = presenter.actors
        labelPlot.text = presenter.plot
    }
}
