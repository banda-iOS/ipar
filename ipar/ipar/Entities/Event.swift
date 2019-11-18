//
//  Event.swift
//  ipar
//
//  Created by Elizaveta Dobrianskaia on 11/13/19.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

class Event: Codable {
    var id: Int?
    var name: String
    var description: String?
//    var places: [Place]
    var creator: User
    var images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case creator
        case images
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let id = self.id {
            try container.encode(id, forKey: .id)
        }
        try container.encode(name, forKey: .name)
        if let description = self.description {
            try container.encode(description, forKey: .description)
        }
        try container.encode(creator, forKey: .creator)
        if let images = self.images {
            try container.encode(images, forKey: .images)
        }
    }
    
    init(id: Int, name: String, description: String?, creator: User, images: [String]? = []) {
        self.id = id
        self.name = name
        self.description = description
        self.creator = creator
        self.images = images
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try? container.decode(String.self, forKey: .description)
        self.creator = try container.decode(User.self, forKey: .creator)
        self.images = try? container.decode([String].self, forKey: .images)
    }
}
