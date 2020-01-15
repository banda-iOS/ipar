//
//  AuthViewController.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit

protocol AuthVCDelegate: class {
    func sessionStarts()
}

class AuthViewController: UIViewController, AuthViewProtocol, SignUpVCDelegate, LoginVCDelegate {
    func sessionStarts() {
        dismiss(animated: true, completion: nil)
        delegate?.sessionStarts()
    }
    

    var presenter: AuthPresenterProtocol!
    
    

    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    weak var delegate: AuthVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        let configurator = AuthConfigurator()
        configurator.configure(with: self)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.layer.cornerRadius = 5
        signUpButton.backgroundColor = .midnightGreen
        signUpButton.clipsToBounds = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 5
        loginButton.backgroundColor = .midnightGreen
        loginButton.clipsToBounds = true
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        presenter.openSignUpScreen(vc: self, delegate: self)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        presenter.openLoginScreen(vc: self, delegate: self)
    }
    
    
    func signedUpSuccesfully() {
        dismiss(animated: true, completion: nil)
        delegate?.sessionStarts()
    }
}
