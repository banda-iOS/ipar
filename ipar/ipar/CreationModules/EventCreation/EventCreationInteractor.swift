
import Foundation

class EventCreationInteractor: EventCreationInteractorProtocol {
    
    var presenter: EventCreationPresenterProtocol!
    
    private var fromDate: Date?
    private var toDate: Date?
    
    required init(presenter: EventCreationPresenterProtocol) {
       self.presenter = presenter
   	}
    
    func setDate(_ date: Date, type: DatePickerType) {
        if type == .from {
            fromDate = date
        } else {
            toDate = date
        }
    }
    
}

