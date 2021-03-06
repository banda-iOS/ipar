//
//  PlacesCellView.swift
//  ipar
//
//  Created by Vitaly on 07/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

class PlaceCellView: UIView {
    let numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.textColor = .backgroundRed
        numLabel.layer.cornerRadius = 20.0
        numLabel.layer.borderColor = UIColor.backgroundRed.cgColor
        numLabel.layer.borderWidth = 3
        
        numLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        numLabel.textAlignment = .center
        
        numLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return numLabel
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        return titleLabel
    }()
    
    let addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        return addressLabel
    }()
    
    func addDefaultSettings() {
        self.layer.cornerRadius = 5
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createFields(place: Place, i: Int) {
        self.addSubview(numLabel)
        
        NSLayoutConstraint.activate([
            numLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            numLabel.widthAnchor.constraint(equalToConstant: 40),
            numLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
        numLabel.text = "\(i)"
        
        self.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: numLabel.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        if let name = place.name {
            titleLabel.text = name
        }
        
        self.addSubview(addressLabel)

        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: numLabel.trailingAnchor, constant: 10),
            addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
        ])
        
        if let address = place.address {
            addressLabel.text = address
        }
    }
    
    func wasSelected() {
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemBackground
        } else {
            self.backgroundColor = .white
        }
    }
    
    func wasUnselected() {
        self.backgroundColor = .unselectedColor
    }
}
