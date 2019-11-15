//
//  Place.swift
//  ipar
//
//  Created by Vitaly on 14/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

final class Place: Codable {
    var id: Int?
    var address: String?
    var latitude: Double
    var longitude: Double
    var name: String?
    var description: String?
    var creator: User?
    var hashtags: [String]?
    var comment: String?
    var images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case address
        case latitude
        case longitude
        case name
        case description
        case creator
        case hashtags
        case comment
        case images
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(address, forKey: .address)
        try? container.encode(latitude, forKey: .latitude)
        try? container.encode(longitude, forKey: .longitude)
        try? container.encode(name, forKey: .name)
        try? container.encode(description, forKey: .description)
        try? container.encode(creator, forKey: .creator)
        try? container.encode(hashtags, forKey: .hashtags)
        try? container.encode(comment, forKey: .comment)
        try? container.encode(images, forKey: .images)
    }
    
    init(address: String, latitude: Double, longitude: Double, name: String? = nil, description: String? = nil, creator: User? = nil, hashtags: [String]? = nil) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.description = description
        self.creator = creator
        self.hashtags = hashtags
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(Int.self, forKey: .id)
        self.address = try? container.decode(String.self, forKey: .address)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.name = try? container.decode(String.self, forKey: .name)
        self.description = try? container.decode(String.self, forKey: .description)
        self.creator = try? container.decode(User.self, forKey: .creator)
        self.hashtags = try? container.decode([String].self, forKey: .hashtags)
        self.comment = try? container.decode(String.self, forKey: .comment)
        self.images = try? container.decode([String].self, forKey: .images)
    }
    
}
