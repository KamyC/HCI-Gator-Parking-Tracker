//
//  DDDViewController.swift
//  Gator Parking Tracker
//
//  Created by JinghanCao on 12/5/20.
//

import UIKit

class DDDViewController: UIViewController {

    @IBOutlet var locationText: UITextField!
    @IBOutlet var noteText: UITextField!
    @IBOutlet var dateText: UITextField!
    var timer: Timer!
    var location: String = ""
    var savedDate: String = ""
    var savedNote: String = ""
    var rawDate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationText.text = location
        noteText.text = savedNote
        dateText.text = savedDate
        print("DDD DATE: ", rawDate)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTime), userInfo: nil, repeats: true)
    }
    func endEvent(currentdate: Date, eventdate: Date) {
         if currentdate >= eventdate {
            dateText.text = "Time Due"
             // Stop Timer
             timer.invalidate()
         }
     }

    @objc func UpdateTime() {
        
        //get due date
        let dueComponent = Calendar.current.dateComponents([.day, .year, .month,.hour,.minute,.second], from: rawDate)
        
        let userCalendar = Calendar.current
        // Set Current Date
        let date = Date()
        let components = userCalendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: date)
        let currentDate = userCalendar.date(from: components)!
        
        // Set Event Date
        var eventDateComponents = DateComponents()
        eventDateComponents.year = dueComponent.year
        eventDateComponents.month = dueComponent.month
        eventDateComponents.day = dueComponent.day
        eventDateComponents.hour = dueComponent.hour
        eventDateComponents.minute = dueComponent.minute
        eventDateComponents.second = dueComponent.second
        eventDateComponents.timeZone = TimeZone(abbreviation: "GMT")
        
        // Convert eventDateComponents to the user's calendar
        let eventDate = userCalendar.date(from: eventDateComponents)!
        
        // Change the seconds to days, hours, minutes and seconds
        let timeLeft = userCalendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)
        
        // Display Countdown
        dateText.text = "\(timeLeft.day!)d \(timeLeft.hour!)h \(timeLeft.minute!)m \(timeLeft.second!)s"
        
        // Show diffrent text when the event has passed
        endEvent(currentdate: currentDate, eventdate: eventDate)
    }

}
