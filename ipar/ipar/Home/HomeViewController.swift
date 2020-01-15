//
//  HomeViewController.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, HomeViewProtocol {
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")
        cv.backgroundColor = .none
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return cv
    }()
    var presenter: HomePresenterProtocol!
    let configurator: HomeConfiguratorProtocol = HomeConfigurator()
    var events = [Event]()
    
    let locationManager = CLLocationManager()
    var myLocation: CLLocationCoordinate2D?
    
    private let numberOfColumns = 2

    let titleLabel: UILabel = {
        let label =  UILabel()
        label.text = "Популярное"
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func loadView() {
        super.loadView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        self.view.addSubview(self.titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                titleLabel.textColor = .white
            } else {
                titleLabel.textColor = .black
            }
        } else {
            titleLabel.textColor = .black
        }

        self.setupCollection()
        presenter.getEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupCollection() {

        self.view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")

        collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func eventsLoaded(events: [Event]) {
        self.events = events
        self.collectionView.reloadData()
    }
    
    private func format(distance: CLLocationDistance) -> String {
        return String(format: "%.2f", distance / 1000)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.height - (collectionView.contentInset.top + collectionView.contentInset.bottom + 10)) / CGFloat(numberOfColumns)
        let width = itemSize * 0.8
        return CGSize(width: width, height: itemSize)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Wrong cell")
        }
        let event = events[indexPath.item]
        let place = events[indexPath.item].places[0]
        
        if let location = myLocation {
            let from = CLLocation(latitude: location.latitude, longitude: location.longitude)
            let to = CLLocation(latitude: place.latitude, longitude: place.longitude)
            let distance = "\(format(distance: from.distance(from: to) )) km"
            if let images = event.images, images.count > 0 {
                cell.update(title: event.name, imageLink: images[0], distance: distance)
            } else {
                cell.update(title: event.name, imageLink: nil, distance: distance)
            }
        } else {
            if let images = event.images, images.count > 0 {
                cell.update(title: event.name, imageLink: images[0], distance: nil)
            } else {
                cell.update(title: event.name, imageLink: nil, distance: nil)
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.eventCellWasSelectedWith(indexPathRow: indexPath.row)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        myLocation = locValue
//        presenter.getEvents()
        self.locationManager.stopUpdatingLocation()
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
