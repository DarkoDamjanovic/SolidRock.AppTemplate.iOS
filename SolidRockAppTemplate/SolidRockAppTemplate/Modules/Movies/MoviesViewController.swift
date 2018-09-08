//
//  MoviesViewController.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit

protocol MoviesViewProtocol: class {
    
}

/// Show a list of movies.
class MoviesViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MoviesPresenterProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.navigationItem.title = "movies.title".localized
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI() {
        
    }
}

extension MoviesViewController: MoviesViewProtocol {
    
}
