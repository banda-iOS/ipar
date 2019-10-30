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
    func goToLoginScreen(vc: UIViewController, delegate: LoginVCDelegate) {
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginViewController.delegate = delegate
        loginViewController.modalTransitionStyle = .flipHorizontal
        vc.present(loginViewController, animated: true, completion: nil)
    }
    
    func goToSignUpScreen(vc: UIViewController, delegate: SignUpVCDelegate) {
        let signUpViewController = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        signUpViewController.delegate = delegate
        signUpViewController.modalTransitionStyle = .coverVertical
        vc.present(signUpViewController, animated: true, completion: nil)
    }
    
    
    
    
}
