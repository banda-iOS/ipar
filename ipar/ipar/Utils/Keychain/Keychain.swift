//
//  Keychain.swift
//  ipar
//
//  Created by Vitaly on 27/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import KeychainSwift

let keychain = KeychainSwift()

func addSessionToKeychain(sessionid: String) {
    keychain.set(sessionid, forKey: "sessionid")
}

func getSession() -> String? {
    return keychain.get("sessionid")
}
