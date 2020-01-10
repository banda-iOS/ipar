
import Foundation

class EventsSearchConfigurator: EventsSearchConfiguratorProtocol {
    func configure(with viewController: EventsSearchViewProtocol) {
		let presenter = EventsSearchPresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = EventsSearchInteractor(presenter: presenter)
	presenter.interactor = interactor
	let router = EventsSearchRouter()
	presenter.router = router
        
    }
}