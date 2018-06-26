//
//  CalendarCell.swift
//  CalendarMobile
//
//  Created by C4Q on 6/19/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!{
        didSet {
            dateLabel.layer.cornerRadius = dateLabel.bounds.size.width / 2
            dateLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var eventIndicator: UIView!
    
    public func setTodaysDate() {
        if self.dateLabel.text == Date().day.description {
            self.dateLabel.backgroundColor = .blue
            self.dateLabel.textColor = .white
        } else {
            self.dateLabel.backgroundColor = .clear
            self.dateLabel.textColor = .black
        }
    }
}
