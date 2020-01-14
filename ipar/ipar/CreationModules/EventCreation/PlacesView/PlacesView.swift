//
//  PlacesView.swift
//  ipar
//
//  Created by Vitaly on 07/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit
import MapKit

protocol PlacesViewDelegate: class {
    func openPlaceInAR(_ place: Place)
}

class PlacesView: UIView {
    weak var delegate: PlacesViewDelegate?
    
    fileprivate let placesScrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .justified
        textView.isEditable = false
        return textView
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    var places =  [Place]()
    var placesViews = [PlaceCellView]()
    var pins = [CustomPin]()
    
    func getPlaces() -> [Place] {
        return self.places
    }
    
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
            placeView.arButton.addTarget(self, action: #selector(arButtonPressed), for: .touchUpInside)
            placeView.arButton.tag = i
        }
        
        self.addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionTextView.topAnchor.constraint(equalTo: placesScrollView.bottomAnchor, constant: 10),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        mapView.delegate = self
        self.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        pins = []
        for i in 0..<places.count - 1 {
            drawRoute(from: places[i], to: places[i+1], sourceIndex: i)
        }
        if places.count == 1 {
            let place = places[0]
            let location = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            let pin = CustomPin(pinTitle: place.name ?? "", pinSubTitle: place.address ?? "", location: location)
            pins.append(pin)
            let sourcePlaceMark = MKPlacemark(coordinate: location)
            mapView.addAnnotation(pin)
            mapView.selectAnnotation(pin, animated: true)
        }
        
        selectPlaceWith(index: 0)
        
    }
    
    @objc func arButtonPressed(sender:UIButton) {
        let place = self.places[sender.tag]
        print("hey ar")
        print(place)
        self.delegate?.openPlaceInAR(place)
    }
    
    func selectPlaceWith(index: Int) {
        for (i, placeView) in placesViews.enumerated() {
            if i == index {
                placeView.wasSelected()
                descriptionTextView.text = places[index].description
                self.selectPin(withIndex: index)
            } else {
                placeView.wasUnselected()
            }
        }
    }
    
    func drawRoute(from sourcePlace: Place, to destinationPlace: Place, sourceIndex: Int) {
        
        let directionRequest = MKDirections.Request()
        
        let sourceLocation = CLLocationCoordinate2D(latitude: sourcePlace.latitude, longitude: sourcePlace.longitude)
        let sourcePin = CustomPin(pinTitle: sourcePlace.name ?? "", pinSubTitle: sourcePlace.address ?? "", location: sourceLocation)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        mapView.addAnnotation(sourcePin)
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        
        if sourceIndex == 0 {
            self.pins.append(sourcePin)
        }
        
        let destinationLocation = CLLocationCoordinate2D(latitude: destinationPlace.latitude, longitude: destinationPlace.longitude)
        let destinationPin = CustomPin(pinTitle: destinationPlace.name ?? "", pinSubTitle: destinationPlace.address ?? "", location: destinationLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        mapView.addAnnotation(destinationPin)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        
        self.pins.append(destinationPin)
        
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }

            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveLabels)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func selectPin(withIndex index: Int) {
        mapView.selectAnnotation(pins[index], animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: places[index].latitude, longitude: places[index].longitude), span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension PlacesView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
//        print(type(of: overlay), "\n\n")
//        if overlay is MKTileOverlay {
//            return tileRenderer
//        }
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.random
        renderer.lineWidth = 4.0
        return renderer
    }
}

