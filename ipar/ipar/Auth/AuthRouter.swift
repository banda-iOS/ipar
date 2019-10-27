//
//  AuthRouter.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import UIKit

class AuthRouter: AuthRouterProtocol {
    func goToSignUpScreen(vc: UIViewController, delegate: SignUpVCDelegate) {
        print("signUp")
        let signUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        signUpViewController.delegate = delegate
        signUpViewController.modalTransitionStyle = .coverVertical
        vc.present(signUpViewController, animated: true, completion: nil)
    }
    
    func goToLoginScreen() {
         print("login")
    }
    
    func goToMainScreen() {
        print("toMain")
    }
    
    
}
