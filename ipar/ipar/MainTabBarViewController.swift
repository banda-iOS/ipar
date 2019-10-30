//
//  MainTabBarViewController.swift
//  ipar
//
//  Created by Vitaly on 28/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController, AuthVCDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstViewController = AuthViewController()
        firstViewController.delegate = self
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let tabBarList = [firstViewController]
        viewControllers = tabBarList
        
    }
    
//    MARK: функция, которая запускается, когда сессия стартует
    func sessionStarts() {
        let secondViewController = AuthViewController()
                
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        viewControllers?.append(secondViewController)
    }
    

}
