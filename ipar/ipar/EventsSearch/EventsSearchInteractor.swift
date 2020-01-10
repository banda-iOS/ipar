
import Foundation
import CoreLocation
import Alamofire

class EventsSearchFields {
    var maxDistance: Int = 1000000
    var hashtags: String? = nil
    var name: String? = nil
    var description: String? = nil
    var location: CLLocationCoordinate2D? = nil
    var from: Date = .yesterday
    var to: Date = .tomorrow
    
    func createPath() -> String? {
        var path = "events?distance=\(String(format: "%.3f",Float(maxDistance)/1609.344))"
        guard let location = self.location else {
            return nil
        }
        path += "&latitude=\(location.latitude)&longitude=\(location.longitude)"
        if let hashtags = self.hashtags {
            let hashtagsArray = parseHashTags(hashtagString: hashtags)
            for hashtag in hashtagsArray {
                path += "&hashtag=\(hashtag)"
            }
        }
        if let name = self.name {
            path += "&name=\(name)"
        }
       
        if let description = self.description {
            path += "&description=\(description)"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        path += "&from=\(dateFormatter.string(from: self.from))"
        path += "&to=\(dateFormatter.string(from: self.to))"
        print(path)
        return path
    }
}

class EventsSearchInteractor: EventsSearchInteractorProtocol {
    
    var presenter: EventsSearchPresenterProtocol!
    
    var request: DataRequest?
    
    var events = [Event]()
    
    var fields = EventsSearchFields()
    
    required init(presenter: EventsSearchPresenterProtocol) {
       self.presenter = presenter
   	}
    
    func setLocation(_ location: CLLocationCoordinate2D) {
        self.fields.location = location
    }
   
    func getEvents() {
        self.request?.cancel()
        
        if let path = self.fields.createPath() {
            self.request = getData(byPath: path, callback: eventsCallback(data:))
        }
    }
    
    func eventsCallback(data: Data) {
        do {
            let events: [Event] = try JSONDecoder().decode([Event].self, from: data)
            self.events = events
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
   
    func updateFields(_ fields: EventsSearchFields) {
       self.fields = fields
       self.getEvents()
    }
    
}

