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

        self.tabBar.barTintColor = UIColor(red: 232.0/255, green: 67.0/255, blue: 66.0/255, alpha: 1.0)
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = UIColor(red: 51.0/255, green: 51.0/255, blue: 51.0/255, alpha: 1.0)
        
        if getSession() != nil {
            viewControllers = createMainTBControllerForAuthorized()
            addCentralButton()
        } else {
            viewControllers = createMainTBControllerForUnauthorized()
        }

    }
    
    private func createDefaultControllers() -> [UIViewController] {
        var tabViewControllers = [UIViewController]()
               
        let homeViewController = UIViewController()
        let unselectedHomeImage = UIImage(named: "unselectedHome")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        let selectedHomeImage = UIImage(named: "selectedHome")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: unselectedHomeImage, selectedImage: selectedHomeImage)
        tabViewControllers.append(homeViewController)
       
        let searchViewController = UIViewController()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        tabViewControllers.append(searchViewController)
        
        return tabViewControllers
    }
    
    func createMainTBControllerForAuthorized() -> [UIViewController] {
       
        var tabViewControllers = createDefaultControllers()
        
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        vc.tabBarItem.isEnabled = false
        tabViewControllers.append(vc)
        
        let myEventsViewController = UIViewController()
        myEventsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
        tabViewControllers.append(myEventsViewController)
        
        let meViewController = UIViewController()
        let unselectedMeImage = UIImage(named: "unselectedMe")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        let selectedMeImage = UIImage(named: "selectedMe")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        meViewController.tabBarItem = UITabBarItem(title: "Me", image: unselectedMeImage, selectedImage: selectedMeImage)

        tabViewControllers.append(meViewController)

        return tabViewControllers
    }
    
    func createMainTBControllerForUnauthorized() -> [UIViewController] {
        var tabViewControllers = createDefaultControllers()
       
        let authViewController = AuthViewController()
        authViewController.delegate = self
        tabViewControllers.append(authViewController)

        
        return tabViewControllers
    }
    
    private func addCentralButton() {
        let buttonImage = UIImage(named: "unselectedAddButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0))
        let highlightImage = UIImage(named: "selectedAddButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0))
        if let buttonImage = buttonImage {
            let button = UIButton(type: UIButton.ButtonType.custom)
            
            button.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width, height: buttonImage.size.height)
                        
            button.setBackgroundImage(buttonImage, for: UIControl.State())
            button.setBackgroundImage(highlightImage, for: UIControl.State.highlighted)
                        
            button.center = self.tabBar.center
            if #available(iOS 11.0, *) {
                button.center.y = button.center.y - UIApplication.shared.windows[0].safeAreaInsets.bottom
            }

            self.view.addSubview(button)
        }
    }
    
//    MARK: функция, которая запускается, когда сессия стартует
    func sessionStarts() {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        vc.tabBarItem.isEnabled = false
        viewControllers?[2] = vc
        
        let myEventsViewController = UIViewController()
        myEventsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
        viewControllers?.append(myEventsViewController)
       
        let meViewController = UIViewController()
        let unselectedMeImage = UIImage(named: "unselectedMe")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        let selectedMeImage = UIImage(named: "selectedMe")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        meViewController.tabBarItem = UITabBarItem(title: "Me", image: unselectedMeImage, selectedImage: selectedMeImage)

        viewControllers?.append(meViewController)
        addCentralButton()
        
    }
//    MARK: функция, которая запускается, когда пользователь выходит
    func sessionEnds() {
        
    }
    

}
