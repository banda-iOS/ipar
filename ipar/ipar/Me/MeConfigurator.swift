
import Foundation

class MeConfigurator: MeConfiguratorProtocol {
    func configure(with viewController: MeViewProtocol) {
		let presenter = MePresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = MeInteractor(presenter: presenter)
	presenter.interactor = interactor
	let router = MeRouter()
	presenter.router = router
        
    }
}