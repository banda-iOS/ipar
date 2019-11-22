
import Foundation

protocol HomeViewProtocol: class {
    var presenter: HomePresenterProtocol! { get set }
    
    func eventsLoaded(events: [Event])
}

protocol HomeConfiguratorProtocol: class {
    func configure(with viewController: HomeViewProtocol)
}

protocol HomePresenterProtocol: class {
	var view: HomeViewProtocol! {get set}
	
	var interactor: HomeInteractorProtocol! {get set}
	var router: HomeRouterProtocol! {get set}
    
    func getEvents()
    func gettingEventsFinishedWithSuccess(events: [Event])
    func gettingEventsFinishedWithError(message: String)
}

protocol HomeInteractorProtocol: class {
	var presenter: HomePresenterProtocol! { get set }
    
    func getEvents()
}
	
protocol HomeRouterProtocol: class {
    
}

