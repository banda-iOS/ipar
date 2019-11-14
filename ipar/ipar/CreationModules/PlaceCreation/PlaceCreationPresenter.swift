
import Foundation

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
    
}

