
import Foundation
import UIKit

class MyEventsRouter: MyEventsRouterProtocol {
    func goToEventViewController(vc: MyEventsViewProtocol, event: Event) {
        let eventVC = EventViewController(event: event)
        vc.navigationController?.pushViewController(eventVC, animated: true)
    }
    
    
    
}
