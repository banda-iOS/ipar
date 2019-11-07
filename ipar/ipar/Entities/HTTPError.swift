//
//  HTTPError.swift
//  ipar
//
//  Created by Costa Bobroff on 06/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation


class HTTPError: Codable {
    var status: Int
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encode(message, forKey: .message)
    }
    
    init(message: String, status: Int) {
        self.message = message
        self.status = status
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.status = try container.decode(Int.self, forKey: .status)
    }
}

