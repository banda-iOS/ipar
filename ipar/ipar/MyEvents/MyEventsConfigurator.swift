
import Foundation

class MyEventsConfigurator: MyEventsConfiguratorProtocol {
    func configure(with viewController: MyEventsViewProtocol) {
		let presenter = MyEventsPresenter(view: viewController)
		viewController.presenter = presenter
		
		
	let interactor = MyEventsInteractor(presenter: presenter)
	presenter.interactor = interactor
	let router = MyEventsRouter()
	presenter.router = router
        
    }
}