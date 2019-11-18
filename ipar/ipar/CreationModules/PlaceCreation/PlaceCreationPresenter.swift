
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
    
    func parseHashTags(hashtagString: String) -> [String]{
        if hashtagString.prefix(1) != "#" {
            return []
        }
        var hashtags: [String] = []
        for hashtag in hashtagString.split(separator: "#") {
            hashtags.append(String(hashtag).trimmingCharacters(in: .whitespacesAndNewlines))
        }
        return hashtags

    }
    
    func createPlace() {
        let name = view.getTitleField()
        let description = view.getDescriptionField()
        let hashtags = view.getHashtagsField()
        
        let hashtagsArray = self.parseHashTags(hashtagString: hashtags)
        
        interactor.updatePlaceWith(address: nil, placemark: nil, name: name, description: description, hashtags: hashtagsArray)
        
        interactor.sendToBackend()
    }
    
    func creationFinishedWithSuccess(place: Place) {
        view.hidePositionButton()
        view.hideConfirmButton()
        view.makeHashtagsFieldUneditable()
        view.makeDescriptionFieldUneditable()
        view.makeTitleFieldUneditable()
        view.createCollectionView()
        view.createDoneButton()
    }
    
    func creationFinishedWithError(message: String) {
        
    }
    
    func newImagePicked(_ image: UIImage) {
        interactor.uploadPlaceImage(image)
    }
    
    
}

