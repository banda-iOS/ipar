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

    
    var presenter: SignUpPresenterProtocol!
    let configurator: SignUpConfiguratorProtocol = SignUpConfigurator()
    
    func changeErrorText(text: String) {
        
    }
    

    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmationTextField: UITextField!
    
    @IBOutlet var errorTextView: UITextView!
    
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
