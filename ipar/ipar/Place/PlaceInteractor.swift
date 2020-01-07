
import Foundation

class PlaceInteractor: PlaceInteractorProtocol {
    var presenter: PlacePresenterProtocol!
    
    required init(presenter: PlacePresenterProtocol) {
       self.presenter = presenter
   	}    
    
}

