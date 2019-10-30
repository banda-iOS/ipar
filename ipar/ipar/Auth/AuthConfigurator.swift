//
//  AuthConfigurator.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

class AuthConfigurator: AuthConfiguratorProtocol {
    func configure(with viewController: AuthViewProtocol) {
        let presenter = AuthPresenter(view: viewController)
        let router = AuthRouter()
        
        viewController.presenter = presenter
        presenter.router = router
    }
    
    
}
