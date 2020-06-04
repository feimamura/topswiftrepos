//
//  HomeInteractor.swift
//  TopSwift
//
//  Created by Felipe Imamura on 31/05/20.
//  Copyright © 2020 Felipe Imamura. All rights reserved.
//

import Foundation


class HomeInteractor: PresenterToHomeInteractor {
    
    var presenter: InteractorToHomePresenter?
    
    private var currentPage = 1
    
    
    func loadRepositories(with numRepositoriesPerPage: Int) {
    
        self.performNetworkRequest(currentPage: self.currentPage, numRepositoriesPerPage: numRepositoriesPerPage) { respositories, error in
            self.presenter?.successLoadRepositories(respositories)
        }
    }
    
    
    func refreshData() {
        self.currentPage = 1
    }
    
    
    func loadNextPage(with numRepositoriesPerPage: Int) {
        
        self.currentPage += 1
        
        self.performNetworkRequest(currentPage: self.currentPage, numRepositoriesPerPage: numRepositoriesPerPage) { respositories, error in
            self.presenter?.successLoadNextRepositories(respositories)
        }
    }
    
    
    private func performNetworkRequest(currentPage: Int, numRepositoriesPerPage: Int, completion: @escaping ([Repository], Error?) -> Void) {
        
        let requestUrl = URL(string: "https://api.github.com/search/repositories?q=language%3Aswift&sort=stars&page=\(self.currentPage)&per_page=\(numRepositoriesPerPage)")
        
        let task = URLSession.shared.dataTask(with: requestUrl!) { (data, response, error) in
            
            do {
                if let data = data {
                    let result = try JSONDecoder().decode(RepositoryResponseData.self, from: data)
                    completion(result.items, error)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
