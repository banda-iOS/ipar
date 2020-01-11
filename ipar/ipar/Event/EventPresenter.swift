
import Foundation

class EventPresenter: EventPresenterProtocol {
    
    required init(view: EventViewProtocol) {
       self.view = view
    }
    
    
    var view: EventViewProtocol!
	
	
	var interactor: EventInteractorProtocol!
	var router: EventRouterProtocol!
    
    func getRole(inEvent eventID: Int) {
        interactor.getRole(inEvent: eventID)
    }
    
    func setRole(_ role: Role) {
        switch role.rolename {
        case "Member":
            view.addButton(withColor: .backgroundRed, title: NSLocalizedString("Refuse", comment: "refuse event button"), callback: interactor.refuse(eventID:))
        case "Not a member":
            view.addButton(withColor: .midnightGreen, title: NSLocalizedString("Take part", comment: "take part button"), callback: interactor.takePart(eventID:))
        default:
            break
        }
    }
    
}

