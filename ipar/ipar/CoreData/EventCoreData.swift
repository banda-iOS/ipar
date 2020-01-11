//
//  EventSaving.swift
//  ipar
//
//  Created by Vitaly on 12/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation
import UIKit

class EventCoreData {
    static var shared: EventCoreData = {
        let singleton = EventCoreData()
        return singleton
    }()
    
    func cacheEvent(_ event: Event) {
        if let images = event.images {
            for image in images {
                cacheImage(image)
            }
        }
        for place in event.places {
            cachePlace(place)
        }
        
    }
    
    func cacheImage(_ imageURL: String) {
        getImage(byPath: imageURL, callback: {image in
//            КОДЕС ТУТ
        })
    }
    
    func cachePlace(_ place: Place) {
        
    }
    
}
