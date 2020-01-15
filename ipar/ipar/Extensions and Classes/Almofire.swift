//
//  Almofire.swift
//  ipar
//
//  Created by Vitaly on 15/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
