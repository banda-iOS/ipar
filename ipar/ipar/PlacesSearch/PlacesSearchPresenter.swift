import UIKit
import Foundation
import CoreLocation


class PlacesSearchPresenter: PlacesSearchPresenterProtocol {
    
    required init(view: PlacesSearchViewProtocol) {
       self.view = view
    }
    
    var view: PlacesSearchViewProtocol!
	
	var interactor: PlacesSearchInteractorProtocol!
	var router: PlacesSearchRouterProtocol!
    
    var places = [Place]()
    
    func getPlaces() {
        interactor.getPlaces()
    }
    
    func set(places: [Place]) {
        self.places = places
        view.reloadData()
    }
    
    func getPlacesCount() -> Int {
        return places.count
    }
    
    func getPlaceBy(index: Int) -> Place {
        return places[index]
    }
    
    func setLocationToInteractor(_ location: CLLocationCoordinate2D) {
        interactor.setLocation(location)
    }
    
    func updateFields(_ fields: PlacesSearchFields) {
        interactor.updateFields(fields)
    }
    
    func placeCellWasSelected(place: Place) {
        router.goToPlaceViewController(vc: view, place: place)
    }
    
}

