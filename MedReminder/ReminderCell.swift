//
//  ReminderCell.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 05/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell {
    
    public var reminder: Reminder!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet var imageViewMed: UIImageView!
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var forgotButtonWidthConstrraint: NSLayoutConstraint!
    @IBOutlet weak var takeButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var gapConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.takeButton.layer.borderWidth = 1
        self.forgotButton.layer.borderWidth = 1
        self.editButton.layer.borderColor = UIColor.pink().cgColor
        self.editButton.layer.borderWidth = 1
        
        self.backgroundColor = UIColor.clear
    }
    
    func configureCell(_ reminder: Reminder) {
        self.reminder = reminder

        self.title.text = reminder.title
        self.time.text = reminder.time
        self.imageViewMed.image = (reminder.state == 3) ? UIImage(named: "med1-no") : UIImage(named: "med1-on")
        if reminder.state == 1{
            self.updateButton(button: self.takeButton, color: UIColor.green(), borderColor: UIColor.clear, title: "Taken", titleColor: UIColor.white)
            forgotButtonWidthConstrraint.constant = 0;
            gapConstraint.constant = 0
        }
        else if reminder.state == 2{
            self.updateButton(button: self.forgotButton, color: UIColor.yellow(), borderColor: UIColor.clear, title: "Missed", titleColor: UIColor.white)
            takeButtonWidthConstraint.constant = 0
            gapConstraint.constant = 0
        }
        else if reminder.state == 3{
            self.updateButton(button: self.takeButton, color: UIColor.white, borderColor: UIColor.green(), title: "Take", titleColor: UIColor.green())
            self.updateButton(button: self.forgotButton, color: UIColor.pink(), borderColor: UIColor.clear, title: "Forgot", titleColor: UIColor.white)
            
            forgotButtonWidthConstrraint.constant = 77
            takeButtonWidthConstraint.constant = 77
            gapConstraint.constant = 18
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editReminder(_ sender: UIButton) {
        
    }
    
    @IBAction func takeMed(_ sender: UIButton) {
        self.updateButton(button: self.takeButton, color: UIColor.green(), borderColor: UIColor.clear, title: "Taken", titleColor: UIColor.white)
        forgotButtonWidthConstrraint.constant = 0;
        gapConstraint.constant = 0
        
        self.updateData(key: "state", value: 1)
    }
    
    @IBAction func forgotMed(_ sender: UIButton) {
        self.updateButton(button: self.forgotButton, color: UIColor.yellow(), borderColor: UIColor.clear, title: "Missed", titleColor: UIColor.white)
        takeButtonWidthConstraint.constant = 0
        gapConstraint.constant = 0
        
        self.updateData(key: "state", value: 2)
    }
    
    func updateData(key: String, value: Any){
        let key = self.reminder.reminderKey
        
        var reminder = ["appearance": self.reminder.appearance,
                        "days": self.reminder.days,
                        "dosage": self.reminder.dosage,
                        "state": self.reminder.state,
                        "notification": self.reminder.notification,
                        "time": self.reminder.time,
                        "title": self.reminder.title,
                        ] as [String : Any]
        reminder["state"] = value
        let childUpdates = ["/reminders/\(key)": reminder]
        DataService.dataService.ref.updateChildValues(childUpdates)
    }
    
    func updateButton(button: UIButton, color: UIColor, borderColor: UIColor, title: String, titleColor: UIColor){
        button.layer.borderColor = borderColor.cgColor
        button.backgroundColor = color
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
    }
}
