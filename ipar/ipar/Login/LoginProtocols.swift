
import Foundation

protocol LoginViewProtocol: class{
    var presenter: LoginPresenterProtocol! { get set }
   
    func getLoginField() -> String?
    func getPasswordField() -> String?
    
    func dismissVC()
    func changeTextError()
}

protocol LoginConfiguratorProtocol: class {
    func configure(with viewController: LoginViewProtocol)
}

protocol LoginPresenterProtocol: class {
	var view: LoginViewProtocol! {get set}
	
	
	var interactor: LoginInteractorProtocol! {get set}
    
    func login()
    
    func creationFinishedWithSuccess(user: User)
    func creationFinishedWithError(message: String)
   
}



protocol LoginInteractorProtocol: class {
	var presenter: LoginPresenterProtocol! { get set }
    func login(userToLogin user: LoginUser)
}

