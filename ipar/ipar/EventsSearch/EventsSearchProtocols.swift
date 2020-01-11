
import Foundation
import CoreLocation
import UIKit

protocol EventsSearchViewProtocol: UIViewController {
    var presenter: EventsSearchPresenterProtocol! { get set }
   
    func reloadData()
}

protocol EventsSearchConfiguratorProtocol: class {
    func configure(with viewController: EventsSearchViewProtocol)
}

protocol EventsSearchPresenterProtocol: class {
	var view: EventsSearchViewProtocol! {get set}
	
	
	var interactor: EventsSearchInteractorProtocol! {get set}
	var router: EventsSearchRouterProtocol! {get set}
    
    func getEventBy(index: Int) -> Event
    func getEventsCount() -> Int
    
    func getEvents()
    
    func set(events: [Event])
    
    func setLocationToInteractor(_ location: CLLocationCoordinate2D)
    func updateFields(_ fields: EventsSearchFields)
    
    func eventCellWasSelectedWith(indexPathRow: Int)
}



protocol EventsSearchInteractorProtocol: class {
	var presenter: EventsSearchPresenterProtocol! { get set }
    
    func setLocation(_ location: CLLocationCoordinate2D)
    func getEvents()
    func updateFields(_ fields: EventsSearchFields)
}
	
protocol EventsSearchRouterProtocol: class {
    func goToEventViewController(vc: EventsSearchViewProtocol, event: Event)
}

