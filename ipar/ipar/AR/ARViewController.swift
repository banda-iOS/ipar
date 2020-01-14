//
//  AR.swift
//  ipar
//
//  Created by Vitaly on 12/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit
import ARKit
import ARCoreLocation
import CoreLocation

class ARViewController: UIViewController {
    var landmarker: ARLandmarker!
    let locationManager = CLLocationManager()
    let place: Place
    
    var locationDidSet = false
    
    init(place: Place) {
        self.place = place
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landmarker = ARLandmarker(view: ARSKView(), scene: InteractiveScene(), locationManager: CLLocationManager())
        landmarker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        landmarker.view.frame = self.view.bounds
        landmarker.scene.size = self.view.bounds.size
        self.view.addSubview(landmarker.view)
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func format(distance: CLLocationDistance) -> String {
        return String(format: "%.2f km away", distance / 1000)
    }
    
    func addViewWithMyPosition(myLocation: CLLocationCoordinate2D) {
        let landmarkLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        let from = CLLocation(latitude: myLocation.latitude, longitude: myLocation.longitude)
        let to = CLLocation(latitude: place.latitude, longitude: place.longitude)
        
        landmarkLabel.text = "(\(format(distance: from.distance(from: to) ))km) \(place.name ?? "hello world")"
        landmarkLabel.textAlignment = .center
        landmarkLabel.backgroundColor = .backgroundRed
//        let landmarkARView = ARView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//        landmarkARView.setFields()
//        landmarkARView.placeLabel.text = place.name
        
        let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: self.place.latitude, longitude: self.place.longitude), altitude: 30, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: Date())
        landmarker.addLandmark(view: landmarkLabel, at: location, completion: nil)
    }
}

extension ARViewController: ARLandmarkerDelegate {
    func landmarkDisplayer(_ landmarkDisplayer: ARLandmarker, didFailWithError error: Error) {
        print("Failed! Error: \(error)")
    }
    
    
}

extension ARViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = self.locationManager.location?.coordinate else { return }
        if !locationDidSet {
            self.addViewWithMyPosition(myLocation: locValue)
            locationDidSet = true
            
        }
        
    }
}
