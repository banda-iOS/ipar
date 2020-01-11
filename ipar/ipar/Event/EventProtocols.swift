
import Foundation
import UIKit

protocol EventViewProtocol: class{
    var presenter: EventPresenterProtocol! { get set }
    
    func addButton(withColor color: UIColor, title: String, callback: @escaping((Int)->Void))
}

protocol EventConfiguratorProtocol: class {
    func configure(with viewController: EventViewProtocol)
}

protocol EventPresenterProtocol: class {
	var view: EventViewProtocol! {get set}
	
	
	var interactor: EventInteractorProtocol! {get set}
	var router: EventRouterProtocol! {get set}
    
    func getRole(inEvent eventID: Int)
    func setRole(_ role: Role)
   
}



protocol EventInteractorProtocol: class {
	var presenter: EventPresenterProtocol! { get set }
    func getRole(inEvent eventID: Int)
    
    func takePart(eventID: Int)
    func refuse(eventID: Int)
}
	
protocol EventRouterProtocol: class {

}

