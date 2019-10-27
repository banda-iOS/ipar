//
//  AuthPresenter.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import UIKit

class AuthPresenter: AuthPresenterProtocol {
    func openSignUpScreen(vc: UIViewController, delegate: SignUpVCDelegate) {
        router.goToSignUpScreen(vc: vc, delegate: delegate)
    }
    
    weak var view: AuthViewProtocol!
    var router: AuthRouterProtocol!
    
    required init(view: AuthViewProtocol) {
        self.view = view
    }
    
    
    func openLoginScreen() {
        router.goToLoginScreen()
    }
    
    func openMainScreen() {
        router.goToMainScreen()
    }
    
    
}
