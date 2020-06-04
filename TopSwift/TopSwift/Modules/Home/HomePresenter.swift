//
//  HomePresenter.swift
//  TopSwift
//
//  Created by Felipe Imamura on 31/05/20.
//  Copyright © 2020 Felipe Imamura. All rights reserved.
//

import Foundation

class HomePresenter: ViewToHomePresenter {
    
    var view: PresenterToHomeView?
    var interactor: PresenterToHomeInteractor?
    var router: PresenterToHomeRouter?
    
    private var repositories: [Repository] = []
    private let numRepositoriesPerPage = 20
    
    func loadView() {
        self.view?.willLoadRepositories()
        self.interactor?.loadRepositories(with: numRepositoriesPerPage)
    }
    
    func refreshRepositories() {
        self.interactor?.refreshData()
        self.interactor?.loadRepositories(with: numRepositoriesPerPage)
    }
    
    func numberRepositories() -> Int {
        return self.repositories.count
    }
    
    func repositoriesData(from currentIndex: Int) -> Repository {
        return self.repositories[currentIndex]
    }
    
    private func createIndexPathForNewRepositories() -> [IndexPath] {
        
        var indexPaths: [IndexPath] = []
        for row in self.repositories.count..<self.repositories.count + numRepositoriesPerPage {
            let indexPath = IndexPath(row: row, section: 0)
            indexPaths.append(indexPath)
        }
        return indexPaths
    }
    
    func checkNeedLoadMore(from currentIndex: Int) {
        if currentIndex == self.repositories.count - 5 {
            self.interactor?.loadNextPage(with: numRepositoriesPerPage)
        }
    }
}

extension HomePresenter: InteractorToHomePresenter {
    
    func successLoadNextRepositories(_ repositories: [Repository]) {
        let indexPaths = self.createIndexPathForNewRepositories()
        self.repositories.append(contentsOf: repositories)
        self.view?.showNewRepositories(at: indexPaths)
    }
    
    func successLoadRepositories(_ repositories: [Repository]) {
        self.repositories = repositories
        self.view?.didEndLoadRepositories()
        self.view?.showRepositories()
    }
    
    func failureLoadRepositories() {
        view?.didEndLoadRepositories()
    }
}
