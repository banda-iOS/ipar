
import Foundation

class LoginConfigurator: LoginConfiguratorProtocol {
    func configure(with viewController: LoginViewProtocol) {
		let presenter = LoginPresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = LoginInteractor(presenter: presenter)
	presenter.interactor = interactor
        
    }
}