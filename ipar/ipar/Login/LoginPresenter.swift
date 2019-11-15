
import Foundation

class LoginPresenter: LoginPresenterProtocol {
    func creationFinishedWithSuccess(user: User) {
        view.dismissVC()
    }
    
    func creationFinishedWithError(message: String) {
        
    }
    
    func login() {
        let login = view.getLoginField()
        let password = view.getPasswordField()
        if let login = login,
            let password = password{
            let user = LoginUser(login: login, password: password)
            interactor.login(userToLogin: user)
        }
    }
    
    required init(view: LoginViewProtocol) {
       self.view = view
    }
    
    
    var view: LoginViewProtocol!
	
	
	var interactor: LoginInteractorProtocol!
    
    
}

