//
//  AuthProtocols.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

protocol AuthViewProtocol: class{
    var presenter: AuthPresenterProtocol! { get set }
    func signUpButtonPressed(_ sender: Any)
    func loginButtonPressed(_ sender: Any)
    func continueWithoutAuthButtonPressed(_ sender: Any)
}

protocol AuthPresenterProtocol: class {
    var view: AuthViewProtocol! {get set}
    var router: AuthRouterProtocol! {get set}
    
    func openSignUpScreen()
    func openLoginScreen()
    func openMainScreen()
}

protocol AuthRouterProtocol: class {
    func goToSignUpScreen()
    func goToLoginScreen()
    func goToMainScreen()
}

protocol AuthConfiguratorProtocol: class {
    func configure(with viewController: AuthViewProtocol)
}

