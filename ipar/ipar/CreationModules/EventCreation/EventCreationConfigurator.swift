
import Foundation

class EventCreationConfigurator: EventCreationConfiguratorProtocol {
    func configure(with viewController: EventCreationViewProtocol) {
		let presenter = EventCreationPresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = EventCreationInteractor(presenter: presenter)
	presenter.interactor = interactor
	let router = EventCreationRouter()
	presenter.router = router
        
    }
}