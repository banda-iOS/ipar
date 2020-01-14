
import Foundation
import UIKit

protocol MyEventsViewProtocol: UIViewController {
    var presenter: MyEventsPresenterProtocol! { get set }
   
    func reloadData()
}

protocol MyEventsConfiguratorProtocol: class {
    func configure(with viewController: MyEventsViewProtocol)
}

protocol MyEventsPresenterProtocol: class {
	var view: MyEventsViewProtocol! {get set}
	
	
	var interactor: MyEventsInteractorProtocol! {get set}
	var router: MyEventsRouterProtocol! {get set}
    func getEventsCount() -> Int
    func getEventBy(index: Int) -> Event
    
    func getEvents()
    
    func set(events: [Event])
    func eventCellWasSelectedWith(indexPathRow index: Int)
}



protocol MyEventsInteractorProtocol: class {
	var presenter: MyEventsPresenterProtocol! { get set }
    func getEvents()
}
	
protocol MyEventsRouterProtocol: class {
    func goToEventViewController(vc: MyEventsViewProtocol, event: Event)
}

