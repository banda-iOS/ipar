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
    
    func getNameTextField() -> String? {
        return nameTextField.text
    }
    func getEmailTextField() -> String? {
        return emailTextField.text
    }
    func getPhoneTextField() -> String? {
        return phoneTextField.text
    }
    func getSurnameTextField() -> String? {
        return surnameTextField.text
    }
    func getPasswordTextField() -> String? {
        return passwordTextField.text
    }
    func getPasswordConfirmationTextField() -> String? {
        return passwordTextField.text
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
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

        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
    }
    
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        presenter.createAccountWithValidation()
       
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
        delegate?.signedUpSuccesfully()
    }
    

}
