
import Foundation
import UIKit
import MapKit

protocol PlaceCreationViewProtocol: UIViewController, MapSearchDelegate {
    var presenter: PlaceCreationPresenterProtocol! { get set }
   
}

protocol PlaceCreationConfiguratorProtocol: class {
    func configure(with viewController: PlaceCreationViewProtocol)
}

protocol PlaceCreationPresenterProtocol: class {
	var view: PlaceCreationViewProtocol! {get set}
	
	
	var interactor: PlaceCreationInteractorProtocol! {get set}
	var router: PlaceCreationRouterProtocol! {get set}
   
    func addPositionButtonPressed()
    
    func parseAndSavePlacemarkAndAddress(placemark: MKPlacemark, address: String)
}



protocol PlaceCreationInteractorProtocol: class {
	var presenter: PlaceCreationPresenterProtocol! { get set }
}
	
protocol PlaceCreationRouterProtocol: class {
    func goToMapSearchViewController(vc: PlaceCreationViewProtocol)
}

