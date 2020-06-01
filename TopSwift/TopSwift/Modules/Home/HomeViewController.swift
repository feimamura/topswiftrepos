//
//  HomeViewController.swift
//  TopSwift
//
//  Created by Felipe Imamura on 31/05/20.
//  Copyright © 2020 Felipe Imamura. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var presenter: ViewToHomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension HomeViewController: PresenterToHomeView {
    
}
