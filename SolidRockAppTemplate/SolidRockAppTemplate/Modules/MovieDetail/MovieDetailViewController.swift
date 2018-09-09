//
//  MovieDetailViewController.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 09.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit

protocol MovieDetailViewProtocol: class {

}

class MovieDetailViewController: BaseViewController {
    
    var presenter: MovieDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = presenter.viewTitle
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
}
