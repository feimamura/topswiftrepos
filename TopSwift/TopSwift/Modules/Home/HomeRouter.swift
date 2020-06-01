//
//  HomeRouter.swift
//  TopSwift
//
//  Created by Felipe Imamura on 31/05/20.
//  Copyright © 2020 Felipe Imamura. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: PresenterToHomeRouter {
    
    class func createModule() -> UIViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        
        let presenter: ViewToHomePresenter & InteractorToHomePresenter = HomePresenter()
        let interactor: PresenterToHomeInteractor = HomeInteractor()
        let router: PresenterToHomeRouter = HomeRouter()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view!
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Home", bundle: Bundle.main)
    }
}
