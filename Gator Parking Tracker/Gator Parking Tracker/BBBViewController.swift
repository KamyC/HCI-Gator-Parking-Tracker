//
//  BBBViewController.swift
//  Gator Parking Tracker
//
//  Created by JinghanCao on 11/18/20.
//

import UIKit

class BBBViewController: UIViewController {
    let datePicker = UIDatePicker()
    
    @IBOutlet var locationTextView: UITextField!
    
    @IBOutlet var notesTextView: UITextView!
    
    @IBOutlet var dPicker: UIDatePicker!
    
    var location: String = ""
    var savedDate: String = ""
    var savedNote: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextView.text = location
        notesTextView.layer.cornerRadius = 5
        notesTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        notesTextView.layer.borderWidth = 0.5
        notesTextView.clipsToBounds = true
    }
    func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CCCViewController{
            let data = segue.destination as? CCCViewController
            data?.location = location
            savedDate = date2String(dPicker.date)
            data?.savedDate = savedDate
            data?.savedNote = notesTextView.text
            data?.rawDate = dPicker.date
            print("BBB DATE: ", dPicker.date)
        }
    }

}
