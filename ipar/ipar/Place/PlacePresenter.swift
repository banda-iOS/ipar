
import Foundation

class PlacePresenter: PlacePresenterProtocol {
    required init(view: PlaceViewProtocol) {
       self.view = view
    }
    
    
    var view: PlaceViewProtocol!
	
	
	var interactor: PlaceInteractorProtocol!
	var router: PlaceRouterProtocol!
    
    
}

