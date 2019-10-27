//
//  SignUpInteractor.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import Alamofire

class SignUpInteractor: SignUpInteractorProtocol {
    var presenter: SignUpPresenterProtocol!
    
    required init(presenter: SignUpPresenterProtocol) {
       self.presenter = presenter
   }
    
    func createAccount(user: User) {
        makeRequest(path: "signup", method: .post, data: user, callback: signUpRequestCallback)
        
       
    }
    
    func signUpRequestCallback(response: DataResponse<Any>?) {
        if let response = response {
                   
                   switch response.result {
                      case .success(let value):
                           if let data = response.data {
                               let user: User = try! JSONDecoder().decode(User.self, from: data)
                               presenter.creationFinishedWithSuccess(user: user)
                           }
                           
                       case .failure(let error):
                           presenter.creationFinishedWithError(message: "failure: \(error)")
                       
                       default:
                           presenter.creationFinishedWithError(message: "не удаётся получить ответ")
                   }
               }
    }
    
   
    
    
}
