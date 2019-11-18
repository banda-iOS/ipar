
import Foundation

class PlaceCreationConfigurator: PlaceCreationConfiguratorProtocol {
    func configure(with viewController: PlaceCreationViewProtocol) {
		let presenter = PlaceCreationPresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = PlaceCreationInteractor(presenter: presenter)
	presenter.interactor = interactor
	let router = PlaceCreationRouter()
	presenter.router = router
        
    }
}