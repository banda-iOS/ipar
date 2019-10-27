//
//  HTTPRequest.swift
//  ipar
//
//  Created by Vitaly on 27/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import Alamofire

let urlAddress = "http://localhost:8081/"

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

func makeRequest(path: String, method: HTTPMethod, data: Encodable?, callback: @escaping((DataResponse<Any>?)->Void)){
    var req = URLRequest(url: URL(string: urlAddress+path)!)
    req.httpMethod = method.rawValue
    if let data=data {
        let jsonData = data.toJSONData()
        req.httpBody = jsonData
    }
  
    request(req).responseJSON { response in
        callback(response)
    }
    
    
   
}