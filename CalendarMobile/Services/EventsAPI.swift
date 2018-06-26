//
//  EventsAPI.swift
//  CalendarMobile
//
//  Created by C4Q on 6/21/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import Foundation

enum HTTPVerb: String {
    case POST
}

class EventsAPI {
    private init() {}
    static let manager = EventsAPI()
    
    let url = "http://localhost:8000/events/"
    
    func postEvent(event: Event, errorHandler: @escaping (Error) -> Void) {
        let event = "title=\(event.title)&description=\(event.description)&startTime=\(event.startTime!)&endTime=\(event.endTime!)&day=\(event.day)"
        guard let url = URL(string: url) else {print("badURL"); return}
        var postRequest = URLRequest(url: url)
        postRequest.httpMethod = "POST"
            postRequest.httpBody = event.data(using: .utf8)
            NetworkHelper.manager.performDataTask(with: postRequest,
                                                  completionHandler: {_ in print("Made a post request")},
                                                  errorHandler: errorHandler)
        }
    
    func getEvents(completionHandler: @escaping ([Event]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: url) else {print("badURL"); return}
        let urlRequest = URLRequest(url: url)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let eventInfo = try JSONDecoder().decode([Event].self, from: data)
                completionHandler(eventInfo)
            } catch {
                errorHandler(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: completion, errorHandler: errorHandler)
    }

    func updateEvent(id: Event) {
        guard let url = URL(string: url) else {print("badURL"); return}
        let urlRequest = URLRequest(url: url)
    }
    
    func deleteEvent(id: Event, errorHandler: @escaping (Error?) -> Void) {
        guard let url = URL(string: "\(url)\(id._id!)") else {print("badURL"); return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        NetworkHelper.manager.performDataTask(with: urlRequest, completionHandler: {_ in print("Deleted")}, errorHandler: errorHandler)
        
    }
}
