
import Foundation
import MapKit
import Alamofire

class PlaceCreationInteractor: PlaceCreationInteractorProtocol {

    var presenter: PlaceCreationPresenterProtocol!
    
    private var place: Place? = nil
    
    required init(presenter: PlaceCreationPresenterProtocol) {
       self.presenter = presenter
   	}
    
    func createPlaceWith(placemark: MKPlacemark, address: String) {
        self.place = Place(address: address, latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude)
    }
    
    func updatePlaceWith(address: String? = nil, placemark: MKPlacemark? = nil, name: String? = nil, description: String? = nil, hashtags: [String]? = nil) {
        if let address = address {
            self.place?.address = address
        }
        if let placemark = placemark {
            self.place?.latitude = placemark.coordinate.latitude
            self.place?.longitude = placemark.coordinate.longitude
        }
        if let name = name {
            self.place?.name = name
        }
        if let description = description {
            self.place?.description = description
        }
        if let hashtags = hashtags {
            self.place?.hashtags = hashtags
        }
    }
    
    func sendToBackend() {
        uploadData(path: "places", method: .post, data: self.place, callback: placeUploadCallback)
    }
    
    func placeUploadCallback(response: DataResponse<Any>?) {
        if let response = response {
            switch response.result {
            case .success(_):
                print("success")
                if let data = response.data {
                    do {
                        let place: Place = try JSONDecoder().decode(Place.self, from: data)
                        presenter.creationFinishedWithSuccess(place: place)
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
    
}

