
import Foundation
import CoreLocation
import UIKit

protocol PlacesSearchViewProtocol: UIViewController, AddPlaceDelegate{
    var presenter: PlacesSearchPresenterProtocol! { get set }
    
    func reloadData()
}

protocol PlacesSearchConfiguratorProtocol: class {
    func configure(with viewController: PlacesSearchViewProtocol)
}

protocol PlacesSearchPresenterProtocol: class {
	var view: PlacesSearchViewProtocol! {get set}
	
	
	var interactor: PlacesSearchInteractorProtocol! {get set}
	var router: PlacesSearchRouterProtocol! {get set}
    
    func getPlaces()
    func set(places: [Place])
    
    func getPlacesCount() -> Int
    func getPlaceBy(index: Int) -> Place
    
    func setLocationToInteractor(_ location: CLLocationCoordinate2D)
    
    func updateFields(_ fields: PlacesSearchFields)
    
    func placeCellWasSelected(place: Place)
}



protocol PlacesSearchInteractorProtocol: class {
	var presenter: PlacesSearchPresenterProtocol! { get set }
    
    func getPlaces()
    func setLocation(_ location: CLLocationCoordinate2D)
    
    func updateFields(_ fields: PlacesSearchFields)
}
	
protocol PlacesSearchRouterProtocol: class {
    func goToPlaceViewController(vc: PlacesSearchViewProtocol, place: Place)
}

