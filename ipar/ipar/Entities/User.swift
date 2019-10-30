//
//  User.swift
//  ipar
//
//  Created by Vitaly on 26/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

class User: Codable {
    var id: Int?
    var surname: String
    var name: String
    var phone: String
    var email: String
    var password: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case surname
        case name
        case phone
        case email
        case password
    }
    
    func Encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let id = self.id {
            try container.encode(id, forKey: .id)
        }
        try container.encode(surname, forKey: .surname)
        try container.encode(name, forKey: .name)
        try container.encode(phone, forKey: .phone)
        try container.encode(email, forKey: .email)
    }
    
    init(surname: String, name: String, phone: String, email: String, password: String = "") {
        self.surname = surname
        self.name = name
        self.phone = phone
        self.email = email
        self.password = password
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.name = try container.decode(String.self, forKey: .name)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.email = try container.decode(String.self, forKey: .email)
    }
}
