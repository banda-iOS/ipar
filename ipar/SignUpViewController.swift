//
//  SignUpViewController.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit

protocol SignUpVCDelegate: class {
    func signedUpSuccesfully()
}

class SignUpViewController: UIViewController, SignUpViewProtocol {
    func changeErrorText(text: String) {
        errorTextView.text = text
    }

    
    var presenter: SignUpPresenterProtocol!
    let configurator: SignUpConfiguratorProtocol = SignUpConfigurator()
    

    @IBOutlet private var surnameTextField: UITextField!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var phoneTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var passwordConfirmationTextField: UITextField!
    
    @IBOutlet private var errorTextView: UITextView!
    
    weak var delegate: SignUpVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        if let surname = surnameTextField.text,
                   let name = nameTextField.text,
                   let phone = phoneTextField.text,
                   let email = emailTextField.text,
                   let password = passwordTextField.text,
                   let passwordConfirmation = passwordConfirmationTextField.text
               {
                     presenter.createAccountWithValidation(surname: surname, name: name, email: email, phone: phone, password: password, passwordConfirmation: passwordConfirmation)
               }
       
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
        delegate?.signedUpSuccesfully()
    }
    

}
