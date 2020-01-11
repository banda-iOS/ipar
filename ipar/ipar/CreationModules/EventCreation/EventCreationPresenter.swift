
import Foundation
import UIKit

class EventCreationPresenter: EventCreationPresenterProtocol {
    
    required init(view: EventCreationViewProtocol) {
       self.view = view
    }
    
    
    var view: EventCreationViewProtocol!
	
	
	var interactor: EventCreationInteractorProtocol!
	var router: EventCreationRouterProtocol!
    
    var from: Date = Date()
    var to: Date = Date()
    
    func fromTimeAdded(date: Date) {
        from = date
        view.changeDate(date.toDateString(), withTime: date.toTimeString(), type: .from)
    }
    
    func toTimeAdded(date: Date) {
        to = date
        view.changeDate(date.toDateString(), withTime: date.toTimeString(), type: .to)
    }
 
    func addPlaceButtonPressed() {
        router.goToPlaceSearchViewController(vc: view)
    }
    
    func saveEventButtonPressed() {
        
        guard view.getTitle() != "" else {return}
        guard view.getHashtags() != "" else {return}
        guard view.getDescription() != "" else {return}
        let event = Event(id: nil, name: view.getTitle(), description: view.getDescription(), creator: nil, from: from, to: to)
        
        let hashtags = view.getHashtags()
        event.hashtags = parseHashTags(hashtagString: hashtags)
        
        event.places = view.getPlaces()
        guard event.places.count != 0 else {return}
        
        interactor.saveEvent(event)
        
    }
    func creationFinishedWithSuccess(event: Event) {
        view.eventSaved()
    }
    
    func creationFinishedWithError(message: String) {
        
    }
    
    func newImagePicked(_ image: UIImage) {
        interactor.uploadEventImage(image)
    }
}

