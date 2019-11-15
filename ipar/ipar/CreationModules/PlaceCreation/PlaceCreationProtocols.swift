
import Foundation
import UIKit
import MapKit

protocol PlaceCreationViewProtocol: UIViewController, MapSearchDelegate {
    var presenter: PlaceCreationPresenterProtocol! { get set }
    
    func getTitleField() -> String?
    func getDescriptionField() -> String
    func getHashtagsField() -> String

    func getPlacemark() -> MKPlacemark?
    
    func createMapView()
    func createConfirmButton()
    
    func changePlacemarkOnMapView(_ placemark: MKPlacemark)
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
    
    func createPlace()
    
    func creationFinishedWithSuccess(place: Place)
    func creationFinishedWithError(message: String)
}



protocol PlaceCreationInteractorProtocol: class {
	var presenter: PlaceCreationPresenterProtocol! { get set }
    
    func createPlaceWith(placemark: MKPlacemark, address: String)
    func updatePlaceWith(address: String?, placemark: MKPlacemark?, name: String?, description: String?, hashtags: [String]?)
    
    func sendToBackend()
}
	
protocol PlaceCreationRouterProtocol: class {
    func goToMapSearchViewController(vc: PlaceCreationViewProtocol)
}

