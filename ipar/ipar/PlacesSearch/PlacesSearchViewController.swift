
import UIKit
import CoreLocation
import Kingfisher

protocol AddPlaceDelegate: class {
    func placeAdded(_ place: Place)
}

class PlacesSearchViewController: UIViewController, PlacesSearchViewProtocol  {

    
    var presenter: PlacesSearchPresenterProtocol!
    let configurator: PlacesSearchConfiguratorProtocol = PlacesSearchConfigurator()
    let locationManager = CLLocationManager()
    
    weak var addPlaceDelegate: AddPlaceDelegate?
    
    let placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "PlacesSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "place")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let filterButton = UIButton()
    
    var placesSearchParamsView = PlacesSearchParamsView()
    
    override func loadView() {
        super.loadView()
        
        placesTableView.delegate = self
        placesTableView.dataSource = self
        
        self.view.addSubview(placesTableView)
               
        NSLayoutConstraint.activate([
           placesTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
           placesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
           placesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           placesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
           ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        self.navigationItem.title = NSLocalizedString("PLACE SEARCH", comment: "Place search navigation item title")
        self.navigationController?.navigationBar.barTintColor = .backgroundRed
        
        filterButton.setImage(UIImage(named: "unselectedFilterButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0)), for: .normal)
        filterButton.setImage(UIImage(named: "selectedFilterButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0)), for: .highlighted)
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        

        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        guard let locValue: CLLocationCoordinate2D = self.locationManager.location?.coordinate else { return }
        presenter.setLocationToInteractor(locValue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        placesSearchParamsView = PlacesSearchParamsView(frame: CGRect(x: 0, y: self.navigationController?.navigationBar.frame.size.height ?? 0, width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.size.height ?? 0)))
        placesSearchParamsView.delegate = self
        placesSearchParamsView.isHidden = true
        placesSearchParamsView.createFields()
        view.addSubview(placesSearchParamsView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if !self.placesSearchParamsView.isHidden {
            self.hideOrShowPlacesSearchParamsView()
        }
    }
    
    @objc func filterButtonPressed(){
        self.hideOrShowPlacesSearchParamsView()
    }
    
    func hideOrShowPlacesSearchParamsView() {
        if self.placesSearchParamsView.isHidden {
            filterButton.setImage(UIImage(named: "selectedFilterButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0)), for: .normal)
            UIView.transition(with: view, duration: 0.5, options: .transitionCurlDown, animations: {
                self.placesSearchParamsView.isHidden = false
            })
        } else {
            filterButton.setImage(UIImage(named: "unselectedFilterButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0)), for: .normal)
            placesSearchParamsView.anyFieldChangedValue()
            UIView.transition(with: view, duration: 0.5, options: .transitionCurlUp, animations: {
                self.placesSearchParamsView.isHidden = true
            })
        }
    }
    
    func reloadData() {
        self.placesTableView.reloadData()
    }
}

extension PlacesSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPlacesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "place", for: indexPath) as! PlacesSearchTableViewCell
        let place = presenter.getPlaceBy(index: indexPath.row)
        guard let placeName = place.name, let placeAddress = place.address else {return cell}
        cell.placeTitleLabel.text = "\(placeName)"
        cell.placeAddressLabel.text = "\(placeAddress)"
        let url = URL(string: "https://russiatrek.org/images/photo/vladimir-city-assumption-cathedral.jpg")
        cell.placeImageView.kf.setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = presenter.getPlaceBy(index: indexPath.row)
        presenter.placeCellWasSelected(place: place)
        
    }
}


extension PlacesSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        presenter.setLocationToInteractor(locValue)
        presenter.getPlaces()
        self.locationManager.stopUpdatingLocation()
    }
}

extension PlacesSearchViewController: PlacesSearchParamsDelegate {
    func updateFields(_ fields: PlacesSearchFields) {
        guard let locValue: CLLocationCoordinate2D = self.locationManager.location?.coordinate else { return }
        fields.location = locValue
        presenter.updateFields(fields)
    }
}

extension PlacesSearchViewController: AddPlaceDelegate {
    func placeAdded(_ place: Place) {
        self.addPlaceDelegate?.placeAdded(place)
    }
}


