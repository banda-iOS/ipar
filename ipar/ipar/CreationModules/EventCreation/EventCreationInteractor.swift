
import Foundation
import Alamofire

class EventCreationInteractor: EventCreationInteractorProtocol {
    
    var presenter: EventCreationPresenterProtocol!
    
    private var fromDate: Date?
    private var toDate: Date?
    
    required init(presenter: EventCreationPresenterProtocol) {
       self.presenter = presenter
   	}
    
    var event: Event?
    
    func setDate(_ date: Date, type: DatePickerType) {
        if type == .from {
            fromDate = date
        } else {
            toDate = date
        }
    }
    
    func saveEvent(_ event: Event) {
        uploadData(path: "events", method: .post, data: event, callback: saveEventCallback)
    }
    
    func saveEventCallback(response: DataResponse<Any>?) {
        if let response = response {
            switch response.result {
            case .success(_):
                if let data = response.data {
                    do {
                        let event: Event = try JSONDecoder().decode(Event.self, from: data)
                        self.event = event
                        presenter.creationFinishedWithSuccess(event: event)
                    } catch {
                        do {
                            let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
                            presenter.creationFinishedWithError(message: error.message)
                        } catch {
                            print("Can't decode error: \(data)")
                            return
                        }
                    }
                }
            
            case .failure(let error):
                presenter.creationFinishedWithError(message: "failure: \(error)")
                
            default:
                presenter.creationFinishedWithError(message: "не удаётся получить ответ")
            }
        }
    }
    
    func uploadEventImage(_ image: UIImage) {
        if let id = self.event?.id {
            uploadImage(image, path: "events/\(id)/photo", multipartName: "image", method: .post)
        }
    }
    
}

