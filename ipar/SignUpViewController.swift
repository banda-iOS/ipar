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
        return passwordConfirmationTextField.text
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
    
    @IBOutlet weak var signUpButton: UIButton!
    
    weak var delegate: SignUpVCDelegate?
    
    let titleLabel: UILabel = {
        let label =  UILabel()
        label.text = "Регистрация"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        
        self.scrollView.addSubview(self.titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                self.titleLabel.textColor = .white
            } else {
                self.titleLabel.textColor = .black
            }
        } else {
            self.titleLabel.textColor = .black
        }
        self.titleLabel.textAlignment = .center
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.layer.cornerRadius = 5
        signUpButton.backgroundColor = .midnightGreen
        signUpButton.clipsToBounds = true
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    }
    
    
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        presenter.createAccountWithValidation()
       
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
        delegate?.signedUpSuccesfully()
    }
    

}
