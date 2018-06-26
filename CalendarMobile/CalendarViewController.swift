//
//  ViewController.swift
//  CalendarMobile
//
//  Created by C4Q on 6/19/18.
//  Copyright © 2018 Fr0st. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarCollectionView: UICollectionView! {
        didSet {
            calendarCollectionView.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var createEventButton: UIButton!
    
    @IBAction func createEventPressed(_ sender: UIButton) {
        self.view.addSubview(form)
        let guide = self.view.safeAreaLayoutGuide
        form.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            form.topAnchor.constraint(equalTo: guide.topAnchor),
            form.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            form.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            form.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            ])
    }
    
    let form = EventForm()
    let months = ["January","February","March","April","May","June","July","August","September","October","November", "December"]
    let monthDays = [31,28,31,30,31,30,31,31,30,31,30,31]
    var firstWeekDay: Int?
    var currentMonth = String() {
        didSet {
            monthLabel.text = currentMonth
        }
    }
    var currentDay = Int()
    var eventDict = [Int:[Event]]() {
        didSet {
            calendarCollectionView.reloadData()
            eventTableView.reloadData()
        }
    }
    var eventArray = [Event]() {
        didSet {
            populateDict()
        }
    }
    var eventDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        eventTableView.dataSource = self
        currentMonth = months[Date().month]
        firstWeekDay = Date().firstDay.weekday
        form.submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        eventTableView.rowHeight = 120
        
        calendarCollectionView.selectItem(at: IndexPath(row: Date().day + firstWeekDay! - 2, section: 0), animated: true, scrollPosition: .bottom)
        loadEvents()
    }
    @objc func submitButtonPressed() {
        if form.titleTextField.text == "" || form.descriptionTextView.text == "" {
            //TODO: Alert
            showAlert(title: "Error", message: "Give a title and description")
        } else {
            let createEvent = Event(title: form.titleTextField.text!, description: form.descriptionTextView.text, startTime: form.pickerViewStart.date.timeIntervalSince1970, endTime: form.pickerViewEnd.date.timeIntervalSince1970, day: currentDay, _id: nil)
            EventsAPI.manager.postEvent(event: createEvent, errorHandler: {print($0)})
            form.removeFromSuperview()
            showAlert(title: "Sucess", message: "Event Created!")
        }
    }
    
    private func loadEvents() {
        EventsAPI.manager.getEvents(completionHandler: {self.eventArray = $0}, errorHandler: {print($0)})
        eventDict = [Int:[Event]]()
    }
    private func populateDict() {
        for event in eventArray {
            if eventDict[event.day] == nil {
                eventDict[event.day] = [event]
            } else {
                var current = eventDict[event.day]!
                current.append(event)
                eventDict[event.day] = current
            }
        }
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.form.titleTextField.text = ""
            self.form.descriptionTextView.text = ""
            self.loadEvents()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

///Mark:- CollectionView Extension
extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthDays[Date().month] + firstWeekDay! - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! CalendarCell
        if indexPath.row < firstWeekDay! - 1 {
            cell.dateLabel.isHidden = true
            cell.isUserInteractionEnabled = false
        } else {
            cell.dateLabel.isHidden = false
            cell.isUserInteractionEnabled = true
        }
        if eventDict[indexPath.row - firstWeekDay! + 2] != nil {
            cell.eventIndicator.isHidden = false
        } else {
            cell.eventIndicator.isHidden = true
        }
        cell.layer.borderWidth = 0.5
        cell.backgroundColor = UIColor.clear
        cell.dateLabel.text = (indexPath.row - firstWeekDay! + 2).description
        cell.setTodaysDate()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "HeaderCell", for: indexPath)
        return headerView
    }
    
}
extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCell
        createEventButton.isEnabled = true
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9) }, completion: { finished in
                UIView.animate(withDuration: 0.06, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: .curveEaseIn, animations: { cell.transform = CGAffineTransform(scaleX: 1, y: 1) }, completion: { (_) in
                    cell.backgroundColor = .lightGray
                } )})
        if cell.eventIndicator.isHidden == false {
            eventTableView.isHidden = false
        }
        currentDay = Int(cell.dateLabel.text!)!
        var currentDate = DateComponents()
        currentDate.month = Date().month + 1
        currentDate.day = Int(cell.dateLabel.text!)
        currentDate.year = Date().year + 1
        eventDate = Calendar(identifier: .gregorian).date(from: currentDate)!
        eventTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .clear
        eventTableView.isHidden = true
    }
}
///Mark:- TableView Extension
extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let events = eventDict[currentDay] else {return 0}
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        guard let events = eventDict[currentDay] else {return UITableViewCell()}
        let event = events[indexPath.row]
        cell.configureCell(event: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //TODO: Delete
            let selectedDay = eventDict[currentDay]!.remove(at: indexPath.row)
            EventsAPI.manager.deleteEvent(id: selectedDay, errorHandler: {print($0 ?? "Error")})
            if eventDict[currentDay]?.count == 0 {
                eventDict[currentDay] = nil
            }
        }
    }
    
}
