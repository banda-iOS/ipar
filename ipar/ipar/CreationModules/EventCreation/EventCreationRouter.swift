
import Foundation
import UIKit

class EventCreationRouter: EventCreationRouterProtocol {
    func goToPlaceSearchViewController(vc: EventCreationViewProtocol) {
        let placeSearchVC = PlacesSearchViewController()
        placeSearchVC.addPlaceDelegate = vc
        let placeSearchNavigationController = UINavigationController(rootViewController: placeSearchVC)
        vc.present(placeSearchNavigationController, animated: true, completion: nil)
    }
    

}
