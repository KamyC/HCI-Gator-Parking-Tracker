//
//  CCCViewController.swift
//  Gator Parking Tracker
//
//  Created by JinghanCao on 11/18/20.
//

import UIKit

class CCCViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var cellNum = 1

    @IBOutlet var tableView: UITableView!
    var location: String = ""
    var savedDate: String = ""
    var savedNote: String = ""
    var rawDate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        print(savedNote)
        tableView.delegate = self
        tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNum;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "parkingCell", for: indexPath)
        cell.textLabel?.text = location;
        return cell
    }
    
    func deleteAction(forRowAtIndexPath indexPath:IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive,title: "Delete")
        {
            (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            self.cellNum=0
            self.tableView.reloadData()
        }
        return action
    }
    //swipe configuration
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = self.deleteAction(forRowAtIndexPath: indexPath)
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DDDViewController{
            let data = segue.destination as? DDDViewController
            data?.location = location
            data?.savedNote = savedNote
            data?.savedDate = savedDate
            print(savedDate)
            data?.rawDate = rawDate
        }
    }
}



