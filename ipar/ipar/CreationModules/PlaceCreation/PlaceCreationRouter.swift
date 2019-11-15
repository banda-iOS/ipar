
import Foundation
import UIKit

class PlaceCreationRouter: PlaceCreationRouterProtocol {
    func goToMapSearchViewController(vc: PlaceCreationViewProtocol) {
        let storyboard = UIStoryboard(name: "MapSearch", bundle: nil)
        let mapSearchViewController = storyboard.instantiateViewController(withIdentifier: "MapSearchViewController") as! MapSearchViewController
        mapSearchViewController.delegate = vc
        let mapSearchNavigationController = UINavigationController(rootViewController: mapSearchViewController)
        vc.present(mapSearchNavigationController, animated: true, completion: nil)
    }
}
