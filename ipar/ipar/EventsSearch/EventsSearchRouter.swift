
import Foundation
import UIKit

class EventsSearchRouter: EventsSearchRouterProtocol {
    func goToEventViewController(vc: EventsSearchViewProtocol, event: Event) {
        let eventVC = EventViewController(event: event)
        vc.navigationController?.pushViewController(eventVC, animated: true)
    }
    
    
    
}
