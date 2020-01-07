
import UIKit
import Foundation

protocol EventCreationViewProtocol: UIViewController, AddPlaceDelegate {
    var presenter: EventCreationPresenterProtocol! { get set }
   
    func changeDate(_ dateString: String, withTime timeString: String, type: DatePickerType)
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

}



protocol EventCreationInteractorProtocol: class {
	var presenter: EventCreationPresenterProtocol! { get set }
    
    func setDate(_ date: Date, type: DatePickerType)
}
	
protocol EventCreationRouterProtocol: class {
    func goToPlaceSearchViewController(vc: EventCreationViewProtocol)
}

