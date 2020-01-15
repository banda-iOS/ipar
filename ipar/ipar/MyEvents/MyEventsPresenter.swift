
import Foundation

class MyEventsPresenter: MyEventsPresenterProtocol {
    
    required init(view: MyEventsViewProtocol) {
       self.view = view
    }
    
    
    var view: MyEventsViewProtocol!
	
    var events = [Event]()
	
	var interactor: MyEventsInteractorProtocol!
	var router: MyEventsRouterProtocol!
    
    func getEventsCount() -> Int {
        return events.count
    }
    
    func getEventBy(index: Int) -> Event {
        return events[index]
    }
    
    func getEvents() {
        interactor.getEvents()
    }
    
    func set(events: [Event]) {
        self.events = events
        view.reloadData()
    }
    
    func eventCellWasSelectedWith(indexPathRow index: Int) {
        let event = self.events[index]
        router.goToEventViewController(vc: view, event: event)
    }
    
    
}

