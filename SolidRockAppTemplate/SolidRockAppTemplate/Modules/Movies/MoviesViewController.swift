//
//  MoviesViewController.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit

/// Show a list of movies.
class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        // Separate IBOutlet configuration to didSet
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
