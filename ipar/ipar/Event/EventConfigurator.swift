
import Foundation

class EventConfigurator: EventConfiguratorProtocol {
    func configure(with viewController: EventViewProtocol) {
		let presenter = EventPresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = EventInteractor(presenter: presenter)
	presenter.interactor = interactor
	let router = EventRouter()
	presenter.router = router
        
    }
}