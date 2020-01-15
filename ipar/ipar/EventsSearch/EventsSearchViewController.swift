
import UIKit
import CoreLocation
import Kingfisher

class EventsSearchViewController: UIViewController, EventsSearchViewProtocol  {

    
    var presenter: EventsSearchPresenterProtocol!
    let configurator: EventsSearchConfiguratorProtocol = EventsSearchConfigurator()
    let locationManager = CLLocationManager()
    
    let eventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UINib(nibName: "EventsSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "event")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    let filterButton = UIButton()
    
    var eventsSearchParamsView = EventsSearchParamsView()
    
    override func loadView() {
        super.loadView()
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        self.view.addSubview(eventsTableView)
               
        NSLayoutConstraint.activate([
           eventsTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
           eventsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
           eventsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           eventsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
           ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        self.navigationItem.title = NSLocalizedString("EVENT SEARCH", comment: "Event search navigation item title")
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
        
        eventsSearchParamsView.createFields()
        eventsSearchParamsView.button.addTarget(self, action: #selector(objchideOrShowEventsSearchParamsView), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height ?? 0), width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.size.height ?? 0))
//        eventsSearchParamsView = EventsSearchParamsView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.size.height ?? 0), width: self.view.frame.width, height: self.view.frame.height - (self.navigationController?.navigationBar.frame.size.height ?? 0)))
        eventsSearchParamsView.frame = frame
        eventsSearchParamsView.delegate = self
        eventsSearchParamsView.isHidden = true
        
        view.addSubview(eventsSearchParamsView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if !self.eventsSearchParamsView.isHidden {
            self.hideOrShowEventsSearchParamsView()
        }
    }
    
    @objc func objchideOrShowEventsSearchParamsView() {
        hideOrShowEventsSearchParamsView()
    }
    
    func hideOrShowEventsSearchParamsView() {
        view.endEditing(true)
        if self.eventsSearchParamsView.isHidden {
            filterButton.setImage(UIImage(named: "selectedFilterButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0)), for: .normal)
            UIView.transition(with: view, duration: 0.5, options: .transitionCurlDown, animations: {
                self.eventsSearchParamsView.isHidden = false
            })
//            self.eventsSearchParamsView.addTimeTable()
        } else {
            filterButton.setImage(UIImage(named: "unselectedFilterButton")?.resizeImage(targetSize: CGSize(width: 40.0, height: 40.0)), for: .normal)
            eventsSearchParamsView.anyFieldChangedValue()
            UIView.transition(with: view, duration: 0.5, options: .transitionCurlUp, animations: {
                self.eventsSearchParamsView.isHidden = true
            })
        }
    }
    
    @objc func filterButtonPressed() {
        self.hideOrShowEventsSearchParamsView()
    }
    
    func reloadData() {
        eventsTableView.reloadData()
        eventsSearchParamsView.setEventsCount(presenter.getEventsCount())
    }
}

extension EventsSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getEventsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event", for: indexPath) as! EventsSearchTableViewCell
        let event = presenter.getEventBy(index: indexPath.row) as Event
        guard let from = event.fromString, let to = event.toString else {return cell}
        cell.eventTitleLabel.text = event.name
        cell.distanceToEventLabel.text = ""
//        TODO: Localize
        cell.eventTimeLabel.text = ""
        if  let images = event.images,
            images.count > 0{
            cell.eventImageView.kf.setImage(with: URL(string: staticUrlAddress + images[0]))
        } else {
            cell.eventImageView.kf.setImage(with: URL(string: "https://russiatrek.org/images/photo/vladimir-city-assumption-cathedral.jpg"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.eventCellWasSelectedWith(indexPathRow: indexPath.row)
    }
    

}

extension EventsSearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        presenter.setLocationToInteractor(locValue)
        presenter.getEvents()
        self.locationManager.stopUpdatingLocation()
    }
}

extension EventsSearchViewController: EventsSearchParamsDelegate {
    
    func presentTimeVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    func updateFields(_ fields: EventsSearchFields) {
        guard let locValue: CLLocationCoordinate2D = self.locationManager.location?.coordinate else { return }
        fields.location = locValue
        presenter.updateFields(fields)
    }
    
   
}

