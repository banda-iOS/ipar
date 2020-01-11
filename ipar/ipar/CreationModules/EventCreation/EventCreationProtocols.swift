
import UIKit
import Foundation

protocol EventCreationViewProtocol: UIViewController, AddPlaceDelegate {
    var presenter: EventCreationPresenterProtocol! { get set }
   
    func changeDate(_ dateString: String, withTime timeString: String, type: DatePickerType)
    
    func getTitle() -> String
    func getDescription() -> String
    func getHashtags() -> String
    func getPlaces() -> [Place]
    
    func eventSaved()
    
    
}

protocol EventCreationConfiguratorProtocol: class {
    func configure(with viewController: EventCreationViewProtocol)
}

protocol EventCreationPresenterProtocol: class {
	var view: EventCreationViewProtocol! {get set}
	
	
	var interactor: EventCreationInteractorProtocol! {get set}
	var router: EventCreationRouterProtocol! {get set}
    
    func fromTimeAdded(date: Date)
    func toTimeAdded(date: Date)
    
    func addPlaceButtonPressed()
    
    func saveEventButtonPressed()
    
    func creationFinishedWithSuccess(event: Event)
    func creationFinishedWithError(message: String)
    
    func newImagePicked(_ image: UIImage)

}



protocol EventCreationInteractorProtocol: class {
	var presenter: EventCreationPresenterProtocol! { get set }
    
    func setDate(_ date: Date, type: DatePickerType)
    
    func saveEvent(_ event: Event)
    
    func uploadEventImage(_ image: UIImage)
}
	
protocol EventCreationRouterProtocol: class {
    func goToPlaceSearchViewController(vc: EventCreationViewProtocol)
}

