//
//  DataService.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 05/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class DataService {
    static let dataService = DataService()
    var ref: FIRDatabaseReference! = FIRDatabase.database().reference()

    var BASE_REF: FIRDatabaseReference {
        return ref
    }
    
    var USER_REF: FIRDatabaseReference {
        return ref.child("user")
    }
    
    var REMINDERS_REF: FIRDatabaseReference {
        return  ref.child("reminders")
    }
}
