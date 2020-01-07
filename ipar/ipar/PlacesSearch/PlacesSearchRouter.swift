
import Foundation
import UIKit

class PlacesSearchRouter: PlacesSearchRouterProtocol {
    func goToPlaceViewController(vc: PlacesSearchViewProtocol, place: Place) {
        let placeVC = PlaceViewController(place: place)
        placeVC.addPlaceDelegate = vc
        vc.navigationController?.pushViewController(placeVC, animated: true)
    }
    
    
    
}
