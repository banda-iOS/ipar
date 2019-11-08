
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
    
    weak var delegate: LoginVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
    }
     
    @IBAction func loginButtonPressed(_ sender: Any) {
        presenter.login()
    }
    
    func dismissVC() {
        dismiss(animated: true, completion: nil)
        self.delegate?.sessionStarts()
    }
    
}


