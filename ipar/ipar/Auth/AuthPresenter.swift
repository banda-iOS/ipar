//
//  AuthPresenter.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

class AuthPresenter: AuthPresenterProtocol {
    weak var view: AuthViewProtocol!
    var router: AuthRouterProtocol!
    
    required init(view: AuthViewProtocol) {
        self.view = view
    }
    
    func openSignUpScreen() {
        router.goToSignUpScreen()
    }
    
    func openLoginScreen() {
        router.goToLoginScreen()
    }
    
    func openMainScreen() {
        router.goToMainScreen()
    }
    
    
}
