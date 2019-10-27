//
//  SignUpProtocols.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

protocol SignUpViewProtocol: class{
    var presenter: SignUpPresenterProtocol! { get set }
   
    func changeErrorText(text: String)
    func dismissVC()
}

protocol SignUpPresenterProtocol: class {
    var view: SignUpViewProtocol! {get set}
    var router: SignUpRouterProtocol! {get set}
    var interactor: SignUpInteractorProtocol! {get set}
   
    func createAccountWithValidation(surname: String, name: String, email: String, phone: String, password: String, passwordConfirmation: String)
    
    func creationFinishedWithSuccess(user: User)
    func creationFinishedWithError(message: String)
}

protocol SignUpInteractorProtocol: class {
    var presenter: SignUpPresenterProtocol! { get set }
    
    func createAccount(user: User)
}

protocol SignUpRouterProtocol: class {
   func goToMainScreen()
}

protocol SignUpConfiguratorProtocol: class {
    func configure(with viewController: SignUpViewProtocol)
}
