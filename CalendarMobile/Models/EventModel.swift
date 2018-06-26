//
//  EventModel.swift
//  CalendarMobile
//
//  Created by C4Q on 6/20/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import Foundation

struct Event: Codable {
    let title: String
    let description: String
    let startTime: Double?
    let endTime: Double?
    let day: Int
    let _id: String?
}
