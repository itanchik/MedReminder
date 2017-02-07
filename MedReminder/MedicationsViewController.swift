//
//  MedicationsViewController.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 04/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MedicationsViewController: UIViewController {
    
    var medications = [Reminder]()
    
    @IBOutlet weak var addReminderButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MEDICATIONS"
        let navbarFont = UIFont.boldSystemFont(ofSize: 22)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.tableView.register(UINib(nibName: "MedicationCell", bundle: nil), forCellReuseIdentifier: "MedicationCell")
        
        DataService.dataService.REMINDERS_REF.observe(.value, with: { (snapshot) in
            self.medications = []
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let reminder = Reminder(key: key, dictionary: postDictionary)
                        self.medications.insert(reminder, at: 0)
                    }
                }
                
            }

            self.tableView.reloadData()
        })
        
    }
    
    @IBAction func addNewReminder(_ sender: UIButton) {
        let modalViewController = self.storyboard!.instantiateViewController(withIdentifier: "NewReminderViewController")
        (modalViewController as! NewReminderViewController).createNewReminder()
        modalViewController.modalPresentationStyle = .overFullScreen
        present(modalViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MedicationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medications.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let reminder = medications[indexPath.row]
        let cellIdentifier = "MedicationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MedicationCell
        cell.delegate = self
        cell.configureCell(reminder)

        return cell
    }
}

extension MedicationsViewController: MedicationCellDelegate {
    // You get notified by the cell instance and the button when it was pressed
    func medicationCell(_ cell: MedicationCell, didPressButton: UIButton) {
        // Get the indexPath
//        let indexPath = self.tableView.indexPath(for: cell)
//        let reminder = medications[(indexPath?.row)!]
//        let modalViewController = self.storyboard!.instantiateViewController(withIdentifier: "NewReminderViewController")
//        (modalViewController as! NewReminderViewController).editReminder(name: reminder.title, dosage: reminder.dosage, appearance:reminder.appearance, days: reminder.days, time: reminder.time)
//        modalViewController.modalPresentationStyle = .overFullScreen
//        present(modalViewController, animated: true, completion: nil)
    }
}



