//
//  LoginUser.swift
//  ipar
//
//  Created by Vitaly on 30/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation

class LoginUser: Codable {
    var login: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case password
    }
    
    func Encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(login, forKey: .login)
        try container.encode(password, forKey: .password)
    }
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
}
