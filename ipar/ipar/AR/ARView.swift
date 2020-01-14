//
//  ARView.swift
//  ipar
//
//  Created by Vitaly on 14/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

class ARView: UIView {
    let placeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.backgroundColor = .backgroundRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        if #available(iOS 13.0, *) {
            label.backgroundColor = .systemBackground
        } else {
            label.backgroundColor = .white
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setFields() {
        self.addSubview(placeLabel)
        
        NSLayoutConstraint.activate([
            placeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            placeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            placeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            placeLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: 30)
//            distanceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
