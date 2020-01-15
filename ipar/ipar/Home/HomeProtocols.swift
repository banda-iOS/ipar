//
//  HomeProtocols.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewProtocol: UIViewController {
    var presenter: HomePresenterProtocol! { get set }

    func eventsLoaded(events: [Event])
}

protocol HomeConfiguratorProtocol: class {
    func configure(with viewController: HomeViewProtocol)
}

protocol HomePresenterProtocol: class {
    var view: HomeViewProtocol! {get set}

    var interactor: HomeInteractorProtocol! {get set}
    var router: HomeRouterProtocol! {get set}

    func getEvents()
    func gettingEventsFinishedWithSuccess(events: [Event])
    func gettingEventsFinishedWithError(message: String)
    func set(events: [Event])
    func eventCellWasSelectedWith(indexPathRow: Int)
}

protocol HomeInteractorProtocol: class {
    var presenter: HomePresenterProtocol! { get set }

    func getEvents()
}

protocol HomeRouterProtocol: class {
    func goToEventViewController(vc: HomeViewProtocol, event: Event)
}