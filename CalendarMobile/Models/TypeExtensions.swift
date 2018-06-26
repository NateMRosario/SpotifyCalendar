//
//  TypeExtensions.swift
//  CalendarMobile
//
//  Created by C4Q on 6/21/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import Foundation

extension Date {
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    var month: Int {
        return Calendar.current.component(.month, from: self) - 1
    }
    var year: Int {
        return Calendar.current.component(.year, from: self) - 1
    }
    var firstDay: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
    
}
extension String {
    static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter
    }()
    var weekDay: Int {
        return Calendar.current.component(.weekday, from: String.dateFormatter.date(from: self)!)
    }
    
}
