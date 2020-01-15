//
//  HomeRouter.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {
    func goToEventViewController(vc: HomeViewProtocol, event: Event) {
        let eventVC = EventViewController(event: event)
        vc.navigationController?.pushViewController(eventVC, animated: true)
    }
} 
