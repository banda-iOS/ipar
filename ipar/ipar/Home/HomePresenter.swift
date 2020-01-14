//
//  HomePresenter.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    
    required init(view: HomeViewProtocol) {
       self.view = view
    }
    
    var view: HomeViewProtocol!
    var interactor: HomeInteractorProtocol!
    var router: HomeRouterProtocol!
    var events = [Event]()

    func gettingEventsFinishedWithSuccess(events: [Event]) {
        self.view.eventsLoaded(events: events)
    }

    func gettingEventsFinishedWithError(message: String) {
        
        
    }

    func eventCellWasSelectedWith(indexPathRow index: Int) {
        let event = self.events[index]
        router.goToEventViewController(vc: view, event: event)
    }

    func getEvents() {
        interactor.getEvents()
    }

    func set(events: [Event]) {
        self.events = events
    }
}
