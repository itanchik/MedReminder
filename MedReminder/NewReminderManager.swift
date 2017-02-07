//
//  NewReminderViewController.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 04/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import Foundation
import React

@objc(NewReminderManager)
class NewReminderManager: RCTEventEmitter {
  
  override func supportedEvents() -> [String]! {
    return ["NewReminderManagerEvent"]
  }

  @objc func dismissPresentedViewController(_ reactTag: NSNumber) {
    DispatchQueue.main.async {
      if let view = self.bridge.uiManager.view(forReactTag: reactTag) {
        let presentedViewController: UIViewController! = view.reactViewController()
        presentedViewController.dismiss(animated: true, completion: nil)
      }
    }
  }
  
  @objc func save(_ reactTag: NSNumber, title: NSString, time: NSString, dosage: NSString, appearance: Int, days:Int, forIdentifier identifier: Int) -> Void {
    
    let key = DataService.dataService.REMINDERS_REF.childByAutoId().key
    
    let reminder = ["appearance": appearance,
                    "days": String(days),
                    "dosage": dosage,
                    "state": 3,
                    "notification": true,
                    "time": time,
                    "title": title,
                    ] as [String : Any]
    let childUpdates = ["/reminders/\(key)": reminder]
    DataService.dataService.ref.updateChildValues(childUpdates)

    dismissPresentedViewController(reactTag)
    
    self.sendEvent(
      withName: "NewReminderManagerEvent",
      body: ["name": "saveReminder", "currentTitle" : title, "currentTime" : time, "currentDosage": dosage, "currentAppearance": appearance, "currentDays": days, "state" : 3, "notification": true, "extra": identifier])
  }
}
