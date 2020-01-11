
import Foundation
import CoreLocation

class EventsSearchPresenter: EventsSearchPresenterProtocol {
    
    required init(view: EventsSearchViewProtocol) {
       self.view = view
    }
    
    
    var view: EventsSearchViewProtocol!
	
	
	var interactor: EventsSearchInteractorProtocol!
	var router: EventsSearchRouterProtocol!
    
    var events = [Event]()
    
    
    func getEventBy(index: Int) -> Event {
        let event = events[index]
//        event.from = event.fromString?.fromISO8601()
        return event
    }
    
    func getEventsCount() -> Int {
        return events.count
    }
    
    func getEvents() {
        interactor.getEvents()
    }
    
    func set(events: [Event]) {
        self.events = events
        view.reloadData()
    }
    
    func setLocationToInteractor(_ location: CLLocationCoordinate2D) {
        interactor.setLocation(location)
    }
    
    func updateFields(_ fields: EventsSearchFields) {
        interactor.updateFields(fields)
    }
    
    func eventCellWasSelectedWith(indexPathRow index: Int) {
        let event = self.events[index]
        router.goToEventViewController(vc: view, event: event)
    }
}

