
import Foundation

class PlaceCreationInteractor: PlaceCreationInteractorProtocol {
    var presenter: PlaceCreationPresenterProtocol!
    
    required init(presenter: PlaceCreationPresenterProtocol) {
       self.presenter = presenter
   	}    
    
}

