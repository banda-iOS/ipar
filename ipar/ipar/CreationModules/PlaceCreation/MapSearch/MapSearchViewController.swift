//
//  MapSearchViewController.swift
//  ipar
//
//  Created by Vitaly on 13/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit
import MapKit

protocol MapSearchDelegate: class {
    func userSelectedPlacemark(_ placemark: MKPlacemark, address: String)
}

class MapSearchViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, MapSearchTableDelegate {
    
    var resultSearchController:UISearchController? = nil
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var placemark: MKPlacemark?
    
    weak var delegate: MapSearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tableViewController = storyboard!.instantiateViewController(withIdentifier: "MapSearchTableViewController") as! MapSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: tableViewController)
        resultSearchController?.searchResultsUpdater = tableViewController
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        
        containerView.addSubview(searchBar)
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
//        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        tableViewController.mapView = mapView
        tableViewController.previousControllerWithMap = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismissThisController()
    }
    
    private func dismissThisController() {
        self.navigationController?.dismiss(animated: true, completion:nil)
    }
    
    func dropPinAndZoomIn(placemark: MKPlacemark) {
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        self.placemark = placemark
    }
    
    @IBAction func addPlacemarkAndReturn(_ sender: Any) {
        if let placemark = self.placemark {
            delegate?.userSelectedPlacemark(placemark, address: placemark.parseAddress())
            self.dismissThisController()
        } else {
            if self.placemark == nil {
                let alert = UIAlertController(title: NSLocalizedString("Quit without saving?", comment: "Ask for quit without saving in adding placemark to map"), message: NSLocalizedString("Are you sure that you want to quit without saving?", comment: "Ask for quit without saving in adding placemark to map message"), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button"), style: UIAlertAction.Style.cancel, handler: nil))
                alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Yes button"), style: UIAlertAction.Style.destructive, handler: { action in
                    self.dismissThisController()
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
       
        
    }
}
