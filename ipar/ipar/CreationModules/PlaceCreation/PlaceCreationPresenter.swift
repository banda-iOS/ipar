
import Foundation
import MapKit


class PlaceCreationPresenter: PlaceCreationPresenterProtocol {
    
    required init(view: PlaceCreationViewProtocol) {
       self.view = view
    }
    
    
    var view: PlaceCreationViewProtocol!
	
	
	var interactor: PlaceCreationInteractorProtocol!
	var router: PlaceCreationRouterProtocol!
    
    func addPositionButtonPressed() {
        router.goToMapSearchViewController(vc: view)
    }
    
    func parseAndSavePlacemarkAndAddress(placemark: MKPlacemark, address: String) {
        if view.getPlacemark() == nil {
            view.createMapView()
            view.createConfirmButton()
            interactor.createPlaceWith(placemark: placemark, address: address)
        }
        view.changePlacemarkOnMapView(placemark)
        interactor.updatePlaceWith(address: address, placemark: placemark, name: nil, description: nil, hashtags: nil)
    }
    
    func createPlace() {
        let name = view.getTitleField()
        let description = view.getDescriptionField()
        let hashtags = view.getHashtagsField()
        
//        PARSE HASHTAGS
        
        interactor.updatePlaceWith(address: nil, placemark: nil, name: name, description: description, hashtags: ["hashtag", "example"])
        
        interactor.sendToBackend()
    }
    
    func creationFinishedWithSuccess(place: Place) {
        
    }
    
    func creationFinishedWithError(message: String) {
        
    }
    
    
    
}

