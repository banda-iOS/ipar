
import UIKit

protocol LoginVCDelegate: class {
    func sessionStarts()
}

class LoginViewController: UIViewController, LoginViewProtocol  {

    
    func changeTextError() {
        
    }
    
    func getLoginField() -> String? {
        return loginTextField?.text
    }
    
    func getPasswordField() -> String? {
        return passwordTextField?.text
    }
    

    
    var presenter: LoginPresenterProtocol!
    let configurator: LoginConfiguratorProtocol = LoginConfigurator()
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let titleLabel: UILabel = {
        let label =  UILabel()
        label.text = "Авторизация"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    weak var delegate: LoginVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
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
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 5
        loginButton.backgroundColor = .midnightGreen
        loginButton.clipsToBounds = true
    }
     
    @IBAction func loginButtonPressed(_ sender: Any) {
        presenter.login()
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
        self.delegate?.sessionStarts()
    }
    
}


