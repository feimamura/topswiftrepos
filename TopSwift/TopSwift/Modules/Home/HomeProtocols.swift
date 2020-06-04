//
//  HomeProtocols.swift
//  TopSwift
//
//  Created by Felipe Imamura on 31/05/20.
//  Copyright © 2020 Felipe Imamura. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterToHomeView: class {
    
    func willLoadRepositories()
    func didEndLoadRepositories()
    func showRepositories()
    func showNewRepositories(at indexPaths: [IndexPath])
}

protocol InteractorToHomePresenter: class {
    
    func successLoadNextRepositories(_ repositories: [Repository])
    func successLoadRepositories(_ repositories: [Repository])
    func failureLoadRepositories() 
}

protocol PresenterToHomeInteractor: class {
    
    var presenter: InteractorToHomePresenter? {get set}
    
    func loadRepositories(with numRepositoriesPerPage: Int)
    func loadNextPage(with numRepositoriesPerPage: Int)
    func refreshData()
}

protocol ViewToHomePresenter: class {
    
    var view: PresenterToHomeView? {get set}
    var interactor: PresenterToHomeInteractor? {get set}
    var router: PresenterToHomeRouter? {get set}
    
    func loadView()
    
    func refreshRepositories()
    
    func numberRepositories() -> Int
    func repositoriesData(from currentIndex: Int) -> Repository
    
    func checkNeedLoadMore(from currentIndex: Int)
}

protocol PresenterToHomeRouter: class {
    static func createModule() -> UIViewController
}

