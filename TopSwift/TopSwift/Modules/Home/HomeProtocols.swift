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
}

protocol InteractorToHomePresenter: class {
}

protocol PresenterToHomeInteractor: class {
    
    var presenter: InteractorToHomePresenter? {get set}
}

protocol ViewToHomePresenter: class {
    
    var view: PresenterToHomeView? {get set}
    var interactor: PresenterToHomeInteractor? {get set}
    var router: PresenterToHomeRouter? {get set}
}

protocol PresenterToHomeRouter: class {
    static func createModule() -> UIViewController
}

