//
//  MainTabBarViewController.swift
//  ipar
//
//  Created by Vitaly on 28/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit



class MainTabBarViewController: UITabBarController, AuthVCDelegate, MeVCDelegate {

    private var button = UIButton()
    
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
        homeViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Home", comment: "MainPage tab"), image: unselectedHomeImage, selectedImage: selectedHomeImage)
        tabViewControllers.append(homeViewController)
       
        let searchViewController = UIViewController()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        tabViewControllers.append(searchViewController)
        
        return tabViewControllers
    }
    
    private func createAuthViewController() -> UIViewController {
        let authViewController = AuthViewController()
        authViewController.delegate = self
        let unselectedMeImage = UIImage(named: "unselectedMe")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        let selectedMeImage = UIImage(named: "selectedMe")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        authViewController.tabBarItem = UITabBarItem(title: NSLocalizedString("Authorization", comment: "Authorization tab"), image: unselectedMeImage, selectedImage: selectedMeImage)
        return authViewController
    }
    
    private func createEventsViewController() -> UIViewController {
        let myEventsViewController = UIViewController()
        myEventsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
        
        return myEventsViewController
    }
    
    private func createMeViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Me", bundle: nil)
        let meViewController = storyboard.instantiateViewController(withIdentifier: "MeViewController") as! MeViewController
        meViewController.delegate = self
        
        let meNavigationController = UINavigationController(rootViewController: meViewController)
        
        let unselectedMeImage = UIImage(named: "unselectedMe")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        let selectedMeImage = UIImage(named: "selectedMe")?.resizeImage(targetSize: CGSize(width: 30.0, height: 25.0))
        meNavigationController.tabBarItem = UITabBarItem(title: NSLocalizedString("Me", comment: "Profile tab"), image: unselectedMeImage, selectedImage: selectedMeImage)
        
        return meNavigationController
    }
    
    private func createMainTBControllerForAuthorized() -> [UIViewController] {
       
        var tabViewControllers = createDefaultControllers()
        
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        vc.tabBarItem.isEnabled = false
        tabViewControllers.append(vc)
        
        tabViewControllers.append(createEventsViewController())
                
        tabViewControllers.append(createMeViewController())

        return tabViewControllers
    }
    
    private func createMainTBControllerForUnauthorized() -> [UIViewController] {
        var tabViewControllers = createDefaultControllers()
        
        tabViewControllers.append(createAuthViewController())
        
        return tabViewControllers
    }
    
    private func addCentralButton() {
        let buttonImage = UIImage(named: "unselectedAddButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0))
        let highlightImage = UIImage(named: "selectedAddButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0))
        if let buttonImage = buttonImage {
            button = UIButton(type: UIButton.ButtonType.custom)
            
            button.frame = CGRect(x: 0.0, y: 0.0, width: buttonImage.size.width, height: buttonImage.size.height)
                        
            button.setBackgroundImage(buttonImage, for: UIControl.State())
            button.setBackgroundImage(highlightImage, for: UIControl.State.highlighted)
                        
            button.center.x = self.tabBar.center.x
            button.center.y = UIScreen.main.bounds.height - 25.0
            
            if #available(iOS 11.0, *) {
                button.center.y = button.center.y - UIApplication.shared.windows[0].safeAreaInsets.bottom
            }
            
            self.view.addSubview(button)
            
            button.addTarget(self, action: #selector(openCreationTabBarViewController), for: .touchUpInside)
            
        }
    }
    
    @objc func openCreationTabBarViewController() {
//        let creationTabBarViewController = CreationTabBarViewController()
//        let creationNavigationController = UINavigationController(rootViewController: creationTabBarViewController)
//        creationNavigationController.modalPresentationStyle = .fullScreen
//        self.present(creationNavigationController, animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Creation", bundle: nil)
        let creationTabBarViewController = storyboard.instantiateViewController(withIdentifier: "CreationTabBarNavigationController") as! UINavigationController
        creationTabBarViewController.modalPresentationStyle = .fullScreen
        self.present(creationTabBarViewController, animated: true, completion: nil)
    }
    
//    MARK: функция, которая запускается, когда сессия стартует
    func sessionStarts() {
        let vc = UIViewController()
        vc.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        vc.tabBarItem.isEnabled = false
        viewControllers?[2] = vc
        
        viewControllers?.append(createEventsViewController())

        viewControllers?.append(createMeViewController())
        addCentralButton()
        
    }
    
//    MARK: функция, которая запускается, когда пользователь выходит
    func sessionFinished() {
        button.removeFromSuperview()
        viewControllers?[2] = self.createAuthViewController()
        viewControllers?.remove(at: 4)
        viewControllers?.remove(at: 3)
    }
    

}
