
import Foundation

class MyEventsInteractor: MyEventsInteractorProtocol {
    
    var presenter: MyEventsPresenterProtocol!
    
    required init(presenter: MyEventsPresenterProtocol) {
       self.presenter = presenter
   	}
    
    func getEvents() {
        getData(byPath: "events/my", callback: eventsCallback(data:))
    }
    
    func eventsCallback(data: Data) {
        do {
            let events: [Event] = try JSONDecoder().decode([Event].self, from: data)
            presenter.set(events: events)
        } catch {
              do {
                let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
                print(error.message)
              } catch {
                if String(data: data, encoding: .utf8) == "null" {
                    presenter.set(events: [Event]())
                }
                print("Can't decode error")
                return
            }
        }
    }
    
}

