//
//  MovieDetailViewController.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit
import SDWebImage

enum MovieDetailViewState {
    case loading
    case presenting
}

protocol MovieDetailViewProtocol: class {
    func loadUI()
    var viewState: MovieDetailViewState { get set }
}

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelDirector: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelActors: UILabel!
    @IBOutlet weak var labelPlot: UILabel!
    @IBOutlet weak var viewLoadingIndicator: UIView!
    
    var presenter: MovieDetailPresenterProtocol!
    private var viewStateInternal: MovieDetailViewState = .loading
    
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
    var viewState: MovieDetailViewState {
        get {
            return viewStateInternal
        }
        
        set {
            viewStateInternal = newValue
            switch viewStateInternal {
            case .loading:
                viewLoadingIndicator.isHidden = false
            case .presenting:
                viewLoadingIndicator.isHidden = true
            }
        }
    }
    
    func loadUI() {
        imageViewPoster.sd_setImage(with: presenter.imagePosterURL, completed: nil)
        
        labelTitle.text = presenter.title
        labelTitle.font = presenter.titleFont.rawValue
        labelTitle.textColor = presenter.titleColor.rawValue
        
        labelYear.text = presenter.year
        labelYear.font = presenter.yearFont.rawValue
        labelYear.textColor = presenter.yearColor.rawValue
        
        labelGenre.text = presenter.genre
        labelGenre.font = presenter.genreFont.rawValue
        labelGenre.textColor = presenter.genreColor.rawValue
        
        labelDirector.text = presenter.director
        labelDirector.font = presenter.directorFont.rawValue
        labelDirector.textColor = presenter.directorColor.rawValue
        
        labelActors.text = presenter.actors
        labelActors.font = presenter.actorsFont.rawValue
        labelActors.textColor = presenter.actorsColor.rawValue
        
        labelPlot.text = presenter.plot
        labelPlot.font = presenter.plotFont.rawValue
        labelPlot.textColor = presenter.plotColor.rawValue
    }
}
