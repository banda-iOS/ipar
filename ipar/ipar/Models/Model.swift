//
//  Model.swift
//  ipar
//
//  Created by Costa Bobroff on 14/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation
import RealmSwift

class EventModel: Object {
    @objc dynamic var id = 0
//    let id = RealmOptional<Int>()
    @objc dynamic var name: String?
    @objc dynamic var info: String?
    @objc dynamic var from: Date?
    @objc dynamic var to: Date?
    @objc dynamic var creator: UserModel?
    let images = List<ImageModel>()
    let hashtags = List<HashTagModel>()
    let places = List<PlaceModel>()
//    override class func primaryKey() -> String? {
//        return "id"
//    }

}

class PlaceModel: Object {
    let id = RealmOptional<Int>()
    @objc dynamic var address: String? = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var name: String? = ""
    @objc dynamic var info: String? = ""
    @objc dynamic var creator: UserModel?
    let hashtags = List<HashTagModel>()
    @objc dynamic var comment: String?
    let images = List<ImageModel>()
    
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }

}

class UserModel: Object {
    @objc dynamic var id = 0
//    let id = RealmOptional<Int>()
    @objc dynamic var surname: String?
    @objc dynamic var name: String?
    @objc dynamic var phone: String?
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    @objc dynamic var avatarPath: String?
    
//    override class func primaryKey() -> String? {
//        return "id"
//    }
}


class ImageModel: Object {
    @objc dynamic var image: String? = ""
}

class HashTagModel: Object {
    @objc dynamic var hashtag: String? = ""
}

class RealmManager {
    static var shared: RealmManager = {
        let singleton = RealmManager()
        return singleton
    }()

    func cacheEvent(_ event: Event) {

        let eventCache = EventModel()
        let realm = try! Realm()

        if let id = event.id {
            eventCache.id = id
        }
        eventCache.name = event.name
        eventCache.from = event.from
        eventCache.to = event.to
        eventCache.info = event.description

        for place in event.places {
            let placeCache = self.createPlace(place)
            eventCache.places.append(placeCache)
        }

        if let creator = event.creator {
            eventCache.creator = self.createUser(creator)
        }

        if let images = event.images {
            for image in images {
                eventCache.images.append(self.createImage(image))
            }
        }

        if let hashtags = event.hashtags {
            for hashtag in hashtags {
                eventCache.hashtags.append(self.createHashtag(hashtag))
            }
        }

        try! realm.write {
            realm.add(eventCache)
        }

        
    }

    func createUser(_ userObj: User) -> UserModel {
        let user = UserModel()
        
        if let id = userObj.id {
           user.id = id
        }
        user.surname = userObj.surname
        user.name = userObj.name
        user.phone = userObj.phone
        user.email = userObj.email
        user.password = userObj.password
        user.avatarPath = userObj.avatarPath
        
        return user
    }
    
    func createPlace(_ placeObj: Place) -> PlaceModel {
        let place = PlaceModel()

        place.address = placeObj.address
        place.longitude = placeObj.longitude
        place.latitude = placeObj.latitude
        place.name = placeObj.name
        place.info = placeObj.description
        
        if let creator = placeObj.creator {
            place.creator = self.createUser(creator)
        }
        if let hashtags = placeObj.hashtags {
            for hashtag in hashtags {
                place.hashtags.append(self.createHashtag(hashtag))
            }
        }
        if let images = placeObj.images {
            for image in images {
                place.images.append(self.createImage(image))
            }
        }
        
        return place
    }
    
    func createImage(_ imageObj: String) -> ImageModel {
        let image = ImageModel()
        image.image = imageObj
        
        return image
    }
    
    func createHashtag(_ hashtagObj: String) -> HashTagModel {
        let hashtag = HashTagModel()
        hashtag.hashtag = hashtagObj
        
        return hashtag
    }
    
    func getEvent(_ id: Int) -> Event{
        let realm = try! Realm()
        
        let result = realm.objects(EventModel.self).filter("id == %@ ", id)[0]
        
        return serializeEvent(result)
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func createDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("images")
        if !fileManager.fileExists(atPath: paths){
            do {
                try fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Couldn't create document directory")
            }
        }else{
            print("Already directory created.")
        }
    }
    
    func saveImageToDocumentDirectory(_ url: String) {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(url)
        let image = UIImage(named: url)
        let imageData = image!.jpegData(compressionQuality: 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getImage(imageName : String)-> UIImage?{
            let fileManager = FileManager.default
            let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(imageName)
            if fileManager.fileExists(atPath: imagePath){
                return UIImage(contentsOfFile: imagePath)!
            }else{
                return nil
            }
        }
    func getAllEvents() -> [Event] {
        let realm = try! Realm()
        
        let results = realm.objects(EventModel.self)
        var allEvents = [Event]()
        
        for event in results {
            allEvents.append(serializeEvent(event))
        }
        
        return allEvents
    }
    
    func serializeUser(_ userCache: UserModel?) -> User? {
        if let user = userCache {
            let newUser = User(surname:user.surname ?? "", name: user.name!, phone: user.phone ?? "", email: user.email ?? "", password: user.password ?? "")
            newUser.avatarPath = user.avatarPath
            return newUser
            
        }
        return nil
    }
    
    
    func serializeHashtags(_ hashtags: List<HashTagModel>) -> [String]? {
        var hashtagsObj = [String]()
        for hashtag in hashtags {
            hashtagsObj.append(hashtag.hashtag ?? "")
        }
        return hashtagsObj
    }
    
    func serializePlaces(_ places: List<PlaceModel>) -> [Place] {
        var placesObj = [Place]()
        for place in places {
            let user = serializeUser(place.creator)
            let hashtags = serializeHashtags(place.hashtags)
            let images = serializeImages(place.images)
            let newPlace = Place(address: place.address ?? "", latitude: place.latitude, longitude: place.longitude, name: place.name, description: place.info, creator: user, hashtags: hashtags)
            newPlace.images = images
            
            placesObj.append(newPlace)
        }
        return [Place]()
    }
        
    func serializeImages(_ images: List<ImageModel>) -> [String]? {
        var imagesObj = [String]()
        for image in images {
            imagesObj.append(image.image ?? "")
        }
        return imagesObj
    }
    
    func serializeEvent(_ event: EventModel) -> Event {
        
        let user = serializeUser(event.creator)
        
        let eventObj = Event(id: event.id, name: event.name ?? "", description: event.info, creator: user, from: event.from, to: event.to)
        
        eventObj.places = serializePlaces(event.places)
        eventObj.hashtags = serializeHashtags(event.hashtags)
        eventObj.images = serializeImages(event.images)
        
        return eventObj
    }
    
}

