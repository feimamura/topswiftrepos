//
//  HomeViewController.swift
//  TopSwift
//
//  Created by Felipe Imamura on 31/05/20.
//  Copyright © 2020 Felipe Imamura. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableviewRepositories: UITableView!
    
    var presenter: ViewToHomePresenter?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableview()
        self.setupRefreshControll()
        
        self.presenter?.loadView()
        
    }
    
    func setupTableview() {
        
        self.tableviewRepositories.dataSource = self
        self.tableviewRepositories.delegate = self
        self.tableviewRepositories.addSubview(refreshControl)
        self.tableviewRepositories.tableFooterView = UIView(frame: .zero)
        self.tableviewRepositories.rowHeight = UITableView.automaticDimension
        self.tableviewRepositories.estimatedRowHeight = 180.0
        self.tableviewRepositories.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    func setupRefreshControll() {
        
        self.refreshControl.tintColor = UIColor.darkGray
        self.refreshControl.attributedTitle = NSAttributedString(string: "Refreshing respositories ...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        self.refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        self.presenter?.refreshRepositories()
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberRepositories() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
        cell.repository = self.presenter?.repositoriesData(from: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.presenter?.checkNeedLoadMore(from: indexPath.row)
    }
}

extension HomeViewController: PresenterToHomeView {
    
    
    func willLoadRepositories() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func didEndLoadRepositories() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showRepositories() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
           self.tableviewRepositories.reloadData()
        }
    }
    
    func showNewRepositories(at indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.tableviewRepositories.beginUpdates()
            self.tableviewRepositories.insertRows(at: indexPaths, with: .automatic)
            self.tableviewRepositories.endUpdates()
        }
    }
}
