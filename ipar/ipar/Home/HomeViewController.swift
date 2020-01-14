//
//  HomeViewController.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

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

    let titleLabel: UILabel = {
        let label =  UILabel()
        label.text = "МЕРОПРИЯТИЯ"
        label.font = UIFont(name:"Helvetica Neue", size: 32)
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

        self.view.addSubview(self.titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
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
    
    private func setupCollection() {

        self.view.addSubview(collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")

        collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 400).isActive = true

        collectionView.contentInset = .zero
    }
    
    func eventsLoaded(events: [Event]) {
        self.events = events
        self.collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 20) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Wrong cell")
        }
        let event = events[indexPath.item]
        cell.update(title: event.name, imageLink: event.images![0])
        return cell
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
