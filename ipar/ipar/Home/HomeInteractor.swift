
import Foundation
import Alamofire

class HomeInteractor: HomeInteractorProtocol {
    
    var presenter: HomePresenterProtocol!
    
    required init(presenter: HomePresenterProtocol) {
       self.presenter = presenter
   	}
    
    func getEvents() {
        getData(byPath: "events", callback: eventsCallback(data:))
    }
    
//    func eventsCallback(response: DataResponse<Any>?) {
    func eventsCallback(data: Data) {
        do {
            let events: [Event] = try JSONDecoder().decode([Event].self, from: data)
            presenter.gettingEventsFinishedWithSuccess(events: events)
        } catch {

            do {
                let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
                print(error.message)
                presenter.gettingEventsFinishedWithError(message: error.message)
            } catch {
                print("Can't decode error")
                return
            }

        }
//        if let response = response {
//            switch response.result {
//            case .success( _):
//                if let data = response.data {
//                    do {
//                        let events: [Event] = try JSONDecoder().decode([Event].self, from: data)
//                        presenter.gettingEventsFinishedWithSuccess(events: events)
//                    } catch {
//                        do {
//                            let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
//                            presenter.gettingEventsFinishedWithError(message: error.message)
//                        } catch {
//                            print("Can't decode error: \(data)")
//                            return
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                presenter.gettingEventsFinishedWithError(message: "failure: \(error)")
//
//            default:
//                presenter.gettingEventsFinishedWithError(message: "не удаётся получить ответ")
//        }
//    }
}
}
