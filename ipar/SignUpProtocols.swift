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
    
    func getNameTextField() -> String
    func getSurnameTextField() -> String
    func getPhoneTextField() -> String
    func getEmailTextField() -> String
    func getPasswordTextField() -> String
    func getPasswordConfirmationTextField() -> String
    
}

protocol SignUpPresenterProtocol: class {
    var view: SignUpViewProtocol! {get set}
    var interactor: SignUpInteractorProtocol! {get set}
   
//    func createAccountWithValidation(surname: String, name: String, email: String, phone: String, password: String, passwordConfirmation: String)
    func createAccountWithValidation()
    
    func creationFinishedWithSuccess(user: User)
    func creationFinishedWithError(message: String)
}

protocol SignUpInteractorProtocol: class {
    var presenter: SignUpPresenterProtocol! { get set }
    
    func createAccount(withUser user: User)
}


protocol SignUpConfiguratorProtocol: class {
    func configure(with viewController: SignUpViewProtocol)
}
