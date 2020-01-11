
import Foundation

class EventInteractor: EventInteractorProtocol {

    var presenter: EventPresenterProtocol!
    
    required init(presenter: EventPresenterProtocol) {
       self.presenter = presenter
   	}
    
    var eventID: Int?
    
    func getRole(inEvent eventID: Int) {
        getData(byPath: "/events/\(eventID)/role", callback: roleCallback(data:))
        self.eventID = eventID
    }
    
    func roleCallback(data: Data) {
        do {
            print(String(data: data, encoding: .utf8))
            let role: Role = try JSONDecoder().decode(Role.self, from: data)
            presenter.setRole(role)
        } catch {
              do {
                let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
                print(error.message)
              } catch {
                print("Can't decode error")
                return
            }
        }
    }
    
    func takePart(eventID: Int) {
        put(byPath: "/events/\(eventID)/takepart", callback: takePartRefuseCallback(data:))
    }
    
    func refuse(eventID: Int) {
        put(byPath: "/events/\(eventID)/refuse", callback: takePartRefuseCallback(data:))
    }
    
    func takePartRefuseCallback(data: Data) {
        if let id = self.eventID {
            getRole(inEvent: id)
        }
    }
    
}

