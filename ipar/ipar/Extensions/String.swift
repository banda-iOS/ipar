//
//  String.swift
//  ipar
//
//  Created by Vitaly on 29/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

extension String {
    func fromISO8601() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
}
