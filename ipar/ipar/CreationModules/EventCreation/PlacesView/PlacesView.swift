//
//  PlacesView.swift
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
//                addressLabel.heightAnchor.constraint(equalToConstant: 40),
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
        if #available(iOS 13.0, *) {
            self.backgroundColor = .systemGray
        } else {
            self.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
        }
    }
}

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
    var placesViews = [PlaceCellView]()
    
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
            let placeView = PlaceCellView()
            placesViews.append(placeView)
            
            placesScrollView.addSubview(placeView)
            
            placeView.addDefaultSettings()
            
            let gestureRecognizer = BindableGestureRecognizer {
                self.selectPlaceWith(index: i)
            }
            
            placeView.addGestureRecognizer(gestureRecognizer)
            
            if i == 0 {
                placeView.leadingAnchor.constraint(equalTo: placesScrollView.leadingAnchor, constant: 10).isActive = true
            } else {
                placeView.leadingAnchor.constraint(equalTo: placesViews[i-1].trailingAnchor, constant: 10).isActive = true
            }
            placeView.topAnchor.constraint(equalTo: placesScrollView.topAnchor).isActive = true
            placeView.heightAnchor.constraint(equalToConstant: 65).isActive = true
            
            if i == places.count - 1 {
                placeView.trailingAnchor.constraint(equalTo: placesScrollView.trailingAnchor, constant: -10).isActive = true
            }
            
            placeView.createFields(place: place, i: i+1)
        }
        
        self.addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionTextView.topAnchor.constraint(equalTo: placesScrollView.bottomAnchor, constant: 10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        selectPlaceWith(index: 0)
        
    }
    
    func selectPlaceWith(index: Int) {
        for (i, placeView) in placesViews.enumerated() {
            if i == index {
                placeView.wasSelected()
                descriptionTextView.text = places[index].description
            } else {
                placeView.wasUnselected()
            }
        }
    }
}

