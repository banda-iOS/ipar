//
//  Role.swift
//  ipar
//
//  Created by Vitaly on 11/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation

final class Role: Codable {
    var rolename: String
    
    enum CodingKeys: String, CodingKey {
        case rolename
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(rolename, forKey: .rolename)
    }
    
    init(rolename: String) {
        self.rolename = rolename
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rolename = try container.decode(String.self, forKey: .rolename)
    }
    
}
