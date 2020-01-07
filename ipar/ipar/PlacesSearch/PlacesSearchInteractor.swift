
import Foundation
import CoreLocation
import UIKit
import Alamofire

class PlacesSearchFields {
    var maxDistance: Int = 1000000
    var hashtags: String? = nil
    var name: String? = nil
    var description: String? = nil
    var address: String? = nil
    var location: CLLocationCoordinate2D? = nil
    
    func createPath() -> String? {
//        TODO: Проверить на мили
        var path = "places?distance=\(String(format: "%.3f",Float(maxDistance)/1609.344))"
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
        
        if let address = self.address {
            path += "&address=\(address)"
        }
        print(path)
        return path
    }
}

class PlacesSearchInteractor: PlacesSearchInteractorProtocol {
    
    var presenter: PlacesSearchPresenterProtocol!
    var location: CLLocationCoordinate2D? = nil
    
    var fields = PlacesSearchFields()
    
    var places = [Place]()
    
    var request: DataRequest?
    
    required init(presenter: PlacesSearchPresenterProtocol) {
       self.presenter = presenter
   	}
    
    func setLocation(_ location: CLLocationCoordinate2D) {
        self.fields.location = location
    }
    
    func getPlaces() {
        self.request?.cancel()
        
        if let path = self.fields.createPath() {
            self.request = getData(byPath: path, callback: placesCallback(data:))
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func placesCallback(data: Data) {
        do {
            let places: [Place] = try JSONDecoder().decode([Place].self, from: data)
            self.places = places
            presenter.set(places: places)
        } catch {
            do {
                let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
                print(error.message)
            } catch {
                if String(data: data, encoding: .utf8) == "null" {
                    presenter.set(places: [Place]())
                }
                print("Can't decode error")
                return
            }
        }
    }
    
    func updateFields(_ fields: PlacesSearchFields) {
        self.fields = fields
        self.getPlaces()
    }
    
    
}

