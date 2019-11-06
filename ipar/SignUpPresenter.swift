//
//  SignUpPresenter.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {
    func creationFinishedWithSuccess(user: User) {
        view.dismissVC()
    }
    
    func creationFinishedWithError(message: String) {
        view.changeErrorText(text: message)
    }
    
    required init(view: SignUpViewProtocol) {
       self.view = view
    }
    
    
    var view: SignUpViewProtocol!
    
    var interactor: SignUpInteractorProtocol!
    
    func createAccountWithValidation(surname: String, name: String, email: String, phone: String, password: String, passwordConfirmation: String) {
        let (isValid, errors) = validateSignup(email: email, password: password, confirmPassword: passwordConfirmation, phone: phone)
        if !isValid {
            var errorsText = ""
            for error in errors {
                errorsText = errorsText + "\(error)\n"
            }
            view.changeErrorText(text: errorsText)
            return
        }
        let user = User(surname: surname, name: name, phone: phone, email: email, password: password)
        interactor.createAccount(user: user)
        
    }
    
    
    
    
}
