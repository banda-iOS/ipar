//
//  Encodable.swift
//  ipar
//
//  Created by Vitaly on 03/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
