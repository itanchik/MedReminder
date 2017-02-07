//
//  Reminder.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 05/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Reminder{
    fileprivate var _reminderKey: String!
    fileprivate var _title: String!
    fileprivate var _time: String!
    fileprivate var _appearance: NSNumber!
    fileprivate var _days: String!
    fileprivate var _dosage: String!
    fileprivate var _state: NSNumber!
    fileprivate var _notification: Bool!
    fileprivate var _reminderRef: FIRDatabaseReference! = FIRDatabase.database().reference()


    var reminderKey: String {
        return _reminderKey
    }
    
    var title: String {
        return _title
    }

    var time: String {
        return _time
    }
    
    var appearance: NSNumber {
        return _appearance
    }
    
    var days: String {
        return _days
    }
    
    var dosage: String {
        return _dosage
    }
    
    var state: NSNumber {
        return _state
    }

    var notification: Bool {
        return _notification
    }
    
    // Initialize the new Reminder

    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._reminderKey = key
        
        if let titleString = dictionary["title"] as? String {
            self._title = titleString
        }
        else{
            self._title = ""
        }
        
        if let timeString = dictionary["time"] as? String {
            self._time = timeString
        }
        else{
            self._time = ""
        }
        
        if let appearanceNumber = dictionary["appearance"] as? NSNumber {
            self._appearance = appearanceNumber
        }
        else{
            self._appearance = 0
        }
        
        if let daysString = dictionary["days"] as? String {
            self._days = daysString//daysString.components(separatedBy: ",") as NSArray

        }
        else{
            self._days = ""
        }

        if let dosageString = dictionary["dosage"] as? String {
            self._dosage = dosageString
        }
        else{
            self._dosage = "0"
        }
        
        if let stateNumber = dictionary["state"] as? NSNumber {
            self._state = stateNumber
        }
        else{
            self._state = false
        }

        if let notificationBool = dictionary["notification"] as? Bool {
            self._notification = notificationBool
        }
        else{
            self._notification = false
        }

        self._reminderRef = DataService.dataService.REMINDERS_REF.child(self._reminderKey)
    }
}
