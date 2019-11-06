
import Foundation

class MeInteractor: MeInteractorProtocol {
    
    var presenter: MePresenterProtocol!
    
    required init(presenter: MePresenterProtocol) {
       self.presenter = presenter
   	}
    
    func signOut() {
        deleteSessionFromKeychain()
        
        presenter.sessionFinished()
    }
    
}

