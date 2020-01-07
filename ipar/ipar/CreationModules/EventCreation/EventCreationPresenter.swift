
import Foundation

class EventCreationPresenter: EventCreationPresenterProtocol {
    
    required init(view: EventCreationViewProtocol) {
       self.view = view
    }
    
    
    var view: EventCreationViewProtocol!
	
	
	var interactor: EventCreationInteractorProtocol!
	var router: EventCreationRouterProtocol!
    
    func fromTimeAdded(date: Date) {
//        закинуть в интерактор
        view.changeDate(date.toDateString(), withTime: date.toTimeString(), type: .from)
    }
    
    func toTimeAdded(date: Date) {
//        закинуть в интерактор
        view.changeDate(date.toDateString(), withTime: date.toTimeString(), type: .to)
        var ints = [0,1,2,3]
        ints.map{$0*3}
    }
 
    func addPlaceButtonPressed() {
        router.goToPlaceSearchViewController(vc: view)
    }
    
}

