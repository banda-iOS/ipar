
import Foundation

class PlacesSearchConfigurator: PlacesSearchConfiguratorProtocol {
    func configure(with viewController: PlacesSearchViewProtocol) {
		let presenter = PlacesSearchPresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = PlacesSearchInteractor(presenter: presenter)
	presenter.interactor = interactor
	let router = PlacesSearchRouter()
	presenter.router = router
        
    }
}