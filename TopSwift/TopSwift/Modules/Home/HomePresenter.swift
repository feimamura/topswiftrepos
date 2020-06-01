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
    
}

extension HomePresenter: InteractorToHomePresenter {
}
