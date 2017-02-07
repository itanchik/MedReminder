//
//  RemindersViewController.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 04/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RemindersViewController: UIViewController{
    
    var reminders = [Reminder]()
    
    @IBOutlet weak var addReminderButton: UIButton!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TODAY'S REMINDERS"
        let navbarFont = UIFont.boldSystemFont(ofSize: 22)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.tableView.register(UINib(nibName: "ReminderCell", bundle: nil), forCellReuseIdentifier: "ReminderCell")
        
        let currentDay: Int = self.getDayOfWeek()
        
        DataService.dataService.REMINDERS_REF.observe(.value, with: { (snapshot) in
            self.reminders = []
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {

                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let reminder = Reminder(key: key, dictionary: postDictionary)
                        if Int(reminder.days)!+1 == currentDay{
                            self.reminders.insert(reminder, at: 0)
                        }
                    }
                }
                
            }
            
            self.tableView.reloadData()
        })
        
    }
    
    func getDayOfWeek()->Int{
        let todayDate = NSDate()
        let myCalendar = Calendar.current
        var myComponents = myCalendar.dateComponents([.weekday], from: todayDate as Date)
        let weekDay = myComponents.weekday
        return weekDay!
        
    }

    @IBAction func addNewReminder(_ sender: UIButton) {
        let modalViewController = self.storyboard!.instantiateViewController(withIdentifier: "NewReminderViewController")
        (modalViewController as! NewReminderViewController).createNewReminder()
        modalViewController.modalPresentationStyle = .overFullScreen
        present(modalViewController, animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Layout React View
       // remindersView.frame = self.view.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension RemindersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
       // let element = elements[indexPath.row]
        let reminder = reminders[indexPath.row]
        // Instantiate a cell
        let cellIdentifier = "ReminderCell"
       // let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
          //  ?? ReminderCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ReminderCell
        
        cell.configureCell(reminder)
        //print(cell.reminder?["one"])
        // Adding the right informations
//        cell.textLabel?.text = "aaa"//element.symbol
//        cell.detailTextLabel?.text = "bbb"//element.name
        
        // Returning the cell
        return cell
    }
}

