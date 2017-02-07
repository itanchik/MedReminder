//
//  NewReminderViewController.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 04/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import UIKit
import React

class NewReminderViewController: UIViewController {
    
    var newReminderView: RCTRootView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createNewReminder(){
        // Add React View
        let x:NSNumber = 1
        newReminderView = MedReminderReactModule.sharedInstance.viewForModule("NewReminderView", initialProperties: ["identifier": x, "currentTitle": "", "currentTime" : "",  "currentDosage": 10, "currentAppearance": 10 , "currentDays": 10])
        self.view.addSubview(newReminderView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Layout React View
        newReminderView.frame = self.view.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
