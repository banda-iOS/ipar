//
//  PlacesView.swift
//  ipar
//
//  Created by Vitaly on 07/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

class PlacesView: UIView {
    fileprivate let placesScrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .justified
        return textView
    }()
    
    var places =  [Place]()
    var placesViews = [UIView]()
    
    func setPlaces(_ places: [Place]) {
        self.places = places
    }
    
    func appendPlace(_ place: Place) {
        places.append(place)
    }
    
    func createFields() {
        
        self.subviews.forEach { $0.removeFromSuperview() }
        
        self.backgroundColor = .backgroundRed
        
        self.addSubview(placesScrollView)
        placesScrollView.showsHorizontalScrollIndicator = false
        
        placesScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        placesScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        placesScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        placesScrollView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        placesScrollView.subviews.forEach { $0.removeFromSuperview() }
        
        placesViews = []
        
        for (i, place) in places.enumerated() {
            let placeView = UIView()
            placesViews.append(placeView)
            
            placesScrollView.addSubview(placeView)
            
//            placeView.layer.borderWidth = 5
//            placeView.layer.borderColor = UIColor.black.cgColor
            placeView.layer.cornerRadius = 5
            placeView.translatesAutoresizingMaskIntoConstraints = false

            if #available(iOS 13.0, *) {
                placeView.backgroundColor = .systemBackground
            } else {
                placeView.backgroundColor = .white
            }
            
            if i == 0 {
                placeView.leadingAnchor.constraint(equalTo: placesScrollView.leadingAnchor, constant: 10).isActive = true
            } else {
                placeView.leadingAnchor.constraint(equalTo: placesViews[i-1].trailingAnchor, constant: 10).isActive = true
            }
//            placeView.centerYAnchor.constraint(equalTo: placesScrollView.centerYAnchor).isActive = true
            placeView.topAnchor.constraint(equalTo: placesScrollView.topAnchor).isActive = true
            placeView.heightAnchor.constraint(equalToConstant: 65).isActive = true
            
            if i == places.count - 1 {
                placeView.trailingAnchor.constraint(equalTo: placesScrollView.trailingAnchor, constant: -10).isActive = true
            }
            
//            Label with place number
            let numLabel = UILabel()
            numLabel.textColor = .backgroundRed
            numLabel.layer.cornerRadius = 20.0
            numLabel.layer.borderColor = UIColor.backgroundRed.cgColor
            numLabel.layer.borderWidth = 3
            
            numLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
            
            numLabel.translatesAutoresizingMaskIntoConstraints = false
            
            placeView.addSubview(numLabel)
            
            NSLayoutConstraint.activate([
                numLabel.leadingAnchor.constraint(equalTo: placeView.leadingAnchor, constant: 10),
                numLabel.widthAnchor.constraint(equalToConstant: 40),
                numLabel.centerYAnchor.constraint(equalTo: placeView.centerYAnchor),
                numLabel.heightAnchor.constraint(equalToConstant: 40),
            ])
            
            numLabel.text = "\(i+1)"
            numLabel.textAlignment = .center
            
//            Label with place title
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
            placeView.addSubview(titleLabel)

            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: numLabel.trailingAnchor, constant: 10),
                titleLabel.topAnchor.constraint(equalTo: placeView.topAnchor, constant: 10),
                titleLabel.heightAnchor.constraint(equalToConstant: 20),
            ])
            
            if let name = place.name {
                titleLabel.text = name
            }
            
//            Label with place address
            let addressLabel = UILabel()
            addressLabel.translatesAutoresizingMaskIntoConstraints = false
            placeView.addSubview(addressLabel)

            NSLayoutConstraint.activate([
                addressLabel.leadingAnchor.constraint(equalTo: numLabel.trailingAnchor, constant: 10),
                addressLabel.trailingAnchor.constraint(equalTo: placeView.trailingAnchor, constant: -10),
                addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
//                addressLabel.heightAnchor.constraint(equalToConstant: 40),
            ])
            
            if let address = place.address {
                addressLabel.text = address
            }
        }
        
        self.addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionTextView.topAnchor.constraint(equalTo: placesScrollView.bottomAnchor, constant: 10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        descriptionTextView.text = """
        Will attempt to recover by breaking constraint
        <NSLayoutConstraint:0x600001ec1d10 'UISV-spacing' H:[UITextField:0x7fb3d854be80]-(5)-[UILabel:0x7fb3d854dae0'm']   (active)>

        Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
        The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.
        
        <NSLayoutConstraint:0x600001ec1d10 'UISV-spacing' H:[UITextField:0x7fb3d854be80]-(5)-[UILabel:0x7fb3d854dae0'm']   (active)>

        Make a symbolic breakpoint at UIViewAlertForUnsatisfiableConstraints to catch this in the debugger.
        The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKitCore/UIView.h> may also be helpful.
        """
        
    }
}
