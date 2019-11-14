//
//  MapSearchTableViewController.swift
//  ipar
//
//  Created by Vitaly on 13/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import UIKit
import MapKit

protocol MapSearchTableDelegate {
    func dropPinAndZoomIn(placemark: MKPlacemark)
}


class MapSearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
    var previousControllerWithMap: MapSearchTableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = selectedItem.parseAddress()
        //parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        previousControllerWithMap?.dropPinAndZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
        let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
            
        }
    }
    
//    func parseAddress(selectedItem:MKPlacemark) -> String {
//        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
//        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
//        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? "," : ""
//        let addressLine = String(
//            format:"%@%@%@%@%@%@%@",
//            selectedItem.subThoroughfare ?? "",
//            firstSpace,
//            selectedItem.thoroughfare ?? "",
//            comma,
//            selectedItem.locality ?? "",
//            secondSpace,
//            selectedItem.administrativeArea ?? ""
//        )
//        return addressLine
//    }

}
