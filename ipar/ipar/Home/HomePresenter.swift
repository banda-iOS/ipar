//
//  HomePresenter.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
func getEvents() {
    interactor.getEvents()
}

required init(view: HomeViewProtocol) {
   self.view = view
}

var view: HomeViewProtocol!
var interactor: HomeInteractorProtocol!
var router: HomeRouterProtocol!

func gettingEventsFinishedWithSuccess(events: [Event]) {
    self.view.eventsLoaded(events: events)
}

func gettingEventsFinishedWithError(message: String) {
    
    }
}
