//
//  HomeInteractor.swift
//  ipar
//
//  Created by Elizabeth Dobryanskaya on 14.01.2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation
import Alamofire

class HomeInteractor: HomeInteractorProtocol {

    var presenter: HomePresenterProtocol!

    required init(presenter: HomePresenterProtocol) {
       self.presenter = presenter
       }
    
    func getEvents() {
        getData(byPath: "events?distance=610.448&latitude=59.884681&longitude=33.458177&from=2020-01-08T02:09:13.000Z&to=2020-01-16T02:09:22.000Z", callback: eventsCallback(data:))
    }

//    func eventsCallback(response: DataResponse<Any>?) {
    func eventsCallback(data: Data) {
        do {
            let events: [Event] = try JSONDecoder().decode([Event].self, from: data)
            presenter.gettingEventsFinishedWithSuccess(events: events)
            presenter.set(events: events)
        } catch {

            do {
                let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
                print(error.message)
                presenter.gettingEventsFinishedWithError(message: error.message)
            } catch {
                print("Can't decode error")
                return
            }

        }
//        if let response = response {
//            switch response.result {
//            case .success( _):
//                if let data = response.data {
//                    do {
//                        let events: [Event] = try JSONDecoder().decode([Event].self, from: data)
//                        presenter.gettingEventsFinishedWithSuccess(events: events)
//                    } catch {
//                        do {
//                            let error: HTTPError = try JSONDecoder().decode(HTTPError.self, from: data)
//                            presenter.gettingEventsFinishedWithError(message: error.message)
//                        } catch {
//                            print("Can't decode error: \(data)")
//                            return
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                presenter.gettingEventsFinishedWithError(message: "failure: \(error)")
//
//            default:
//                presenter.gettingEventsFinishedWithError(message: "не удаётся получить ответ")
//        }
//    }
}
}
