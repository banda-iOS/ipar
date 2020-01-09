//
//  CustomPin.swift
//  ipar
//
//  Created by Vitaly on 07/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import MapKit

class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
