//
//  AuthViewController.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, AuthViewProtocol {
    var presenter: AuthPresenterProtocol!

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let configurator = AuthConfigurator()
        configurator.configure(with: self)
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        presenter.openSignUpScreen()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        presenter.openLoginScreen()
    }
    
    @IBAction func continueWithoutAuthButtonPressed(_ sender: Any) {
        presenter.openMainScreen()
    }
    
}
