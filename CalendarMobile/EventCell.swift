//
//  EventCell.swift
//  CalendarMobile
//
//  Created by C4Q on 6/22/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    func configureCell(event: Event) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeStyle = .short
        let formattedStartTime = Date.init(timeIntervalSince1970: event.startTime!)
        let formattedEndTime = Date.init(timeIntervalSince1970: event.endTime!)
        
        titleLabel.text = event.title
        descriptionView.text = event.description
        startLabel.text = "Start: \(dateFormatter.string(from: formattedStartTime))"
        endLabel.text = "End: \(dateFormatter.string(from: formattedEndTime))"
    }
}
