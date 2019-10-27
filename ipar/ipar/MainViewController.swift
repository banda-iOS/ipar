//
//  MainViewController.swift
//  ipar
//
//  Created by Vitaly on 27/10/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let nextScreenButton = UIButton()
               nextScreenButton.backgroundColor = .blue
               nextScreenButton.layer.cornerRadius = 24.0
               nextScreenButton.setTitleColor(.white, for: .normal)
               nextScreenButton.setTitleColor(.black, for: .highlighted)
               nextScreenButton.setTitle("Push", for: .normal)
               nextScreenButton.addTarget(self, action: #selector(pushNextScreenButtonAction), for: .touchUpInside)
               nextScreenButton.translatesAutoresizingMaskIntoConstraints = false
               self.view.addSubview(nextScreenButton)
               
        var constraints: [NSLayoutConstraint] = [
            nextScreenButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48.0),
            nextScreenButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
            
            nextScreenButton.heightAnchor.constraint(equalToConstant: 48.0)
        ]
        if #available(iOS 11.0, *) {
            constraints.append(nextScreenButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0))
        } else {
             constraints.append(nextScreenButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16.0))
        }
       NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func pushNextScreenButtonAction() {

        let authViewController = AuthViewController(nibName: "AuthViewController", bundle: nil)
        authViewController.modalTransitionStyle = .coverVertical
        self.present(authViewController, animated: true, completion: nil)
   }

}
