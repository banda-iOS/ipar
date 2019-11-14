
import Foundation
import UIKit

class PlaceCreationRouter: PlaceCreationRouterProtocol {
    func goToMapSearchViewController(vc: PlaceCreationViewProtocol) {
        let storyboard = UIStoryboard(name: "MapSearch", bundle: nil)
        let creationTabBarViewController = storyboard.instantiateViewController(withIdentifier: "MapSearchNavigationController") as! UINavigationController
        creationTabBarViewController.modalPresentationStyle = .fullScreen
//        creationTabBarViewController.delegate = vc
        vc.present(creationTabBarViewController, animated: true, completion: nil)
    }
    
    
    
}
