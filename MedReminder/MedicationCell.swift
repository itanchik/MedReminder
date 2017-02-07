//
//  MedicationCell.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 06/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import UIKit

protocol MedicationCellDelegate: class {
    func medicationCell(_ cell: MedicationCell, didPressButton: UIButton)
}

class MedicationCell: UITableViewCell {
    public var reminder: Reminder!
    weak var delegate: MedicationCellDelegate?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dosage: UILabel!
    @IBOutlet var imageViewMed: UIImageView!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var days: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.notificationButton.layer.cornerRadius = 15
        self.notificationButton.backgroundColor = UIColor.green()
        self.notificationButton.layer.borderWidth = 1
        
        self.editButton.layer.cornerRadius = 15
        self.editButton.layer.borderColor = UIColor.pink().cgColor
        self.editButton.layer.borderWidth = 1
        
        self.backgroundColor = UIColor.clear
    }
    
    func configureCell(_ reminder: Reminder) {
        self.reminder = reminder
        
        self.title.text = reminder.title
        self.dosage.text = reminder.dosage + " mg"
        let imageString = "med" + String(describing: reminder.appearance) + "-on"
        self.imageViewMed.image = UIImage(named: imageString)
        if reminder.notification == true{
            self.notificationButton.layer.borderColor = UIColor.clear.cgColor
            self.notificationButton.backgroundColor = UIColor.pink()
            self.notificationButton.setTitle("Off", for: .normal)
            self.notificationButton.setTitleColor(UIColor.white, for: .normal)
        }
        else{
            self.notificationButton.layer.borderColor = UIColor.clear.cgColor
            self.notificationButton.backgroundColor = UIColor.green()
            self.notificationButton.setTitle("On", for: .normal)
            self.notificationButton.setTitleColor(UIColor.white, for: .normal)
        }
        if let path = Bundle.main.path(forResource: "WeekDays", ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for key in dic.keys{
                    if reminder.days == key{
                        let str: String = dic[key] as! String
                        let index = str.index(str.startIndex, offsetBy: 3)
                        self.days.text = str.substring(to: index)
                    }
                }
                
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editMedication(_ sender: UIButton) {
        self.delegate?.medicationCell(self, didPressButton: sender)
    }
    
    @IBAction func changeNotification(_ sender: UIButton) {
        let key = self.reminder.reminderKey
        let reminder = ["appearance": self.reminder.appearance,
                        "days": self.reminder.days,
                        "dosage": self.reminder.dosage,
                        "state": self.reminder.state,
                        "notification": !self.reminder.notification,
                        "time": self.reminder.time,
                        "title": self.reminder.title,
                        ] as [String : Any]
        let childUpdates = ["/reminders/\(key)": reminder]
        DataService.dataService.ref.updateChildValues(childUpdates)
    }
}

