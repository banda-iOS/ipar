
import Foundation

class PlaceConfigurator: PlaceConfiguratorProtocol {
    func configure(with viewController: PlaceViewProtocol) {
		let presenter = PlacePresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = PlaceInteractor(presenter: presenter)
	presenter.interactor = interactor
	let router = PlaceRouter()
	presenter.router = router
        
    }
}