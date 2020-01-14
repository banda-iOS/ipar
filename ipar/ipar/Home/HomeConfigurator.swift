//
//  HomeConfigurator.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation

class HomeConfigurator: HomeConfiguratorProtocol {
    func configure(with viewController: HomeViewProtocol) {
        let presenter = HomePresenter(view: viewController)
        viewController.presenter = presenter

        let interactor = HomeInteractor(presenter: presenter)
        presenter.interactor = interactor
        let router = HomeRouter()
        presenter.router = router
    }
}
