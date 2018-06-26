//
//  LocalHostTests.swift
//  CalendarMobileTests
//
//  Created by C4Q on 6/22/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import XCTest

struct Event: Codable {
    let title: String
    let description: String
    let startTime: Double?
    let endTime: Double?
    let _id: String
}

class LocalHostTests: XCTestCase {
    
    func testsGetEvents() {
        let exp = self.expectation(description: "found events")
        let url = "http://localhost:8000/events/5b2d1b07ee870aecebc55ac9"
        let session = URLSession.shared
        let request = URLRequest(url: URL(string: url)!)
        
        session.dataTask(with: request) { (data, request, error) in
            if let error = error {
                XCTFail("message error: \(error.localizedDescription)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let event = try decoder.decode([Event].self, from: data)
                    XCTAssertEqual(event[0].title, "Note title", "does not equal to expected title")
                } catch {
                    XCTFail("decoding error: \(error.localizedDescription)")
                }
                exp.fulfill()
            } else {
                XCTFail("no data")
            }
        }.resume()
        
        self.wait(for: [exp], timeout: 3.0)
    }
    
}
