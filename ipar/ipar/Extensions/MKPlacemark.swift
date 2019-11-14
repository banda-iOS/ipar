//
//  MKPlacemark.swift
//  ipar
//
//  Created by Vitaly on 14/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import MapKit

extension MKPlacemark {
    func parseAddress() -> String {
        let firstSpace = (self.subThoroughfare != nil && self.thoroughfare != nil) ? " " : ""
        let comma = (self.subThoroughfare != nil || self.thoroughfare != nil) && (self.subAdministrativeArea != nil || self.administrativeArea != nil) ? ", " : ""
        let secondSpace = (self.subAdministrativeArea != nil && self.administrativeArea != nil) ? "," : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            self.subThoroughfare ?? "",
            firstSpace,
            self.thoroughfare ?? "",
            comma,
            self.locality ?? "",
            secondSpace,
            self.administrativeArea ?? ""
        )
        return addressLine
    }
}
