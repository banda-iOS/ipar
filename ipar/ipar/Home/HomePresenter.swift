
import Foundation

class HomePresenter: HomePresenterProtocol {
    func getEvents() {
        interactor.getEvents()
    }
    
    required init(view: HomeViewProtocol) {
       self.view = view
    }
    
    var view: HomeViewProtocol!
	var interactor: HomeInteractorProtocol!
	var router: HomeRouterProtocol!
    
    func gettingEventsFinishedWithSuccess(events: [Event]) {
        
    }
    
    func gettingEventsFinishedWithError(message: String) {
        
    }
}

