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
    var from: Date?
    var to: Date?
    var creator: User?
    var images: [String]?
    var hashtags: [String]?
    var places = [Place]()
    
    enum CodingKeys: String, CodingKey {
        case id = "event_id"
        case name
        case description
        case from
        case to
        case creator
        case images
        case hashtags
        case places
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
        if let hashtags = self.hashtags {
            try container.encode(hashtags, forKey: .hashtags)
        }
        
        try container.encode(self.from?.toISO8601Full(), forKey: .from)
        try container.encode(self.to?.toISO8601Full(), forKey: .to)
        try container.encode(self.places, forKey: .places)
    }
    
    init(id: Int?, name: String, description: String?, creator: User?, images: [String]? = [], from: Date?, to: Date?) {
        self.id = id
        self.name = name
        self.description = description
        self.creator = creator
        self.images = images
        self.from = from
        self.to = to
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try? container.decode(String.self, forKey: .description)
        self.creator = try? container.decode(User.self, forKey: .creator)
        self.images = try? container.decode([String].self, forKey: .images)
        self.hashtags = try? container.decode([String].self, forKey: .hashtags)
        let from = try? container.decode(String.self, forKey: .from)
        self.from = from?.fromISO8601()
        let to = try? container.decode(String.self, forKey: .to)
        self.to = to?.fromISO8601()
        self.places = try container.decode([Place].self, forKey: .places)
    }
}

