//
//  AppDelegate.swift
//  ipar
//
//  Created by Elizaveta Dobrianskaia on 10/14/19.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//       let userObj = User(surname:"Эгуанов", name: "Парфюм", phone: "8900000000", email: "xxx.pb@com", password: "1234567")
//
//        let userObj2 = User(surname:"Глинов", name: "Глиномес", phone: "8900000000", email: "xxx.psv@com", password: "1234567")
//
//        let place1 = Place(address: "asd ads", latitude: 12.2, longitude: 2.2, name: "asd", description: "jasd", creator: userObj2, hashtags: ["лимбо", "имбо"])
//        place1.id = 23
//        let place2 = Place(address: "asdыфвads", latitude: 1.2, longitude: 2.0, name: "asd", description: "jasd", creator: userObj2, hashtags: ["лимбофыв", "имбо"])
//        place2.id = 24
//        let event = Event(id: 13 ,name: "best Day", description: "i can't pee", creator: userObj, images: ["asd", "xxx"], from: Date(), to: Date())
//
//        let event2 = Event(id: 14 ,name: "best Day", description: "i can't pee", creator: userObj, images: ["asd", "xxx"], from: Date(), to: Date())
//
//        event.places = [place1, place2]
//
//        event2.places = [place1, place2]
//        ///убрать
//        RealmManager.shared.cacheEvent(event)
//        RealmManager.shared.cacheEvent(event2)
////        print("result: ", RealmManager.shared.getEvent(13).places)
//
//        let events = RealmManager.shared.getEvent(13)
//        print(events.places)
//
        if Connectivity.isConnectedToInternet {
             print("Connected")
         } else {
             print("No Internet")
        }
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = MainTabBarViewController()
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        
        return true
    }

}

