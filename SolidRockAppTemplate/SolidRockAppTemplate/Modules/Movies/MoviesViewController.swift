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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
    
    private func setup() {
        self.title = presenter.viewTitle
        tableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        if let cellPresenter = presenter.presenterForRowAt(indexPath: indexPath) {
            cell.configure(presenter: cellPresenter)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        log.info("Selected row at indexPath.row: \(indexPath.row)")
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
