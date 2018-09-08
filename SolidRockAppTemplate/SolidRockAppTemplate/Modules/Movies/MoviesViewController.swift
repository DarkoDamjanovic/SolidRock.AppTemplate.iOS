//
//  MoviesViewController.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 07.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import UIKit

protocol MoviesViewProtocol: class {
    func reloadDataSource()
    func deselectRowAt(indexPath: IndexPath, animated: Bool)
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
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MoviesViewController: MoviesViewProtocol {
    func reloadDataSource() {
        tableView.reloadData()
    }
    
    func deselectRowAt(indexPath: IndexPath, animated: Bool) {
        tableView.deselectRow(at: indexPath, animated: animated)
        log.info("Deselected row at indexPath.row: \(indexPath.row)")
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if presenter.movies.indices.contains(indexPath.row) {
            let movie = presenter.movies[indexPath.row]
            cell.textLabel?.text = movie.title
            cell.detailTextLabel?.text = movie.year
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.info("Selected row at indexPath.row: \(indexPath.row)")
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
