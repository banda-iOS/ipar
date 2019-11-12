//
//  HTTPRequest.swift
//  ipar
//
//  Created by Vitaly on 27/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation
import Alamofire

let urlAddress = "http://localhost:8080/"
let staticUrlAddress = "http://localhost:8081/"
//let urlAddress = "http://82.146.62.124:8080/"
//let staticUrlAddress = "http://82.146.62.124:8081/"


func makeRequest(path: String, method: HTTPMethod, data: Encodable?, callback: @escaping((DataResponse<Any>?)->Void)){
    var req = URLRequest(url: URL(string: urlAddress + path)!)
    req.httpMethod = method.rawValue
    if let data = data {
        let jsonData = data.toJSONData()
        req.httpBody = jsonData
    }
  
    request(req).responseJSON { response in
        callback(response)
    }
    
    
   
}

func uploadImage(_ image: UIImage, path: String, method: HTTPMethod) {
    let imgData = image.jpegData(compressionQuality: 0.2)!

    Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "avatar", fileName: "file.jpg", mimeType: "image/jpg")
        }, to: urlAddress + "avatar" )
    { (result) in
        switch result {
        case .success(let upload, _, _):

            upload.uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
            })



        case .failure(let encodingError):
            print(encodingError)
        }
    }
}

func getImage(byPath path: String, callback: @escaping((UIImage)->Void)) {
    request(staticUrlAddress + path, method: .get).response { (responseData) in
        if let data = responseData.data {
            if let image = UIImage(data: data, scale:1) {
                callback(image)
                return
            }
        }
    }
    print("something went wrong")
}

func getData(byPath path: String, callback: @escaping((Data)->Void)) {
    request(urlAddress + path, method: .get).response { (responseData) in
           if let data = responseData.data {
                callback(data)
           }
       }
    print("something went wrong")
}
