//
//  SignUpConfigurator.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

class SignUpConfigurator: SignUpConfiguratorProtocol {
    func configure(with viewController: SignUpViewProtocol) {
        let presenter = SignUpPresenter(view: viewController)
        let interactor = SignUpInteractor(presenter: presenter)
        let router = SignUpRouter()
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    
}
