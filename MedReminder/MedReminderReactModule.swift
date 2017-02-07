//
//  MedReminderReactModule.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 04/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import Foundation
import React

class MedReminderReactModule: NSObject {
    var bridge: RCTBridge?
    
    static let sharedInstance = MedReminderReactModule()
    
    func createBridgeIfNeeded() -> RCTBridge {
        if bridge == nil {
            bridge = RCTBridge.init(delegate: self, launchOptions: nil)
        }
        return bridge!
    }
    
    func viewForModule(_ moduleName: String, initialProperties: [String : Any]?) -> RCTRootView {
        let viewBridge = createBridgeIfNeeded()
        let rootView: RCTRootView = RCTRootView(
            bridge: viewBridge,
            moduleName: moduleName,
            initialProperties: initialProperties)
        return rootView
    }
}

extension MedReminderReactModule: RCTBridgeDelegate {
    func sourceURL(for bridge: RCTBridge!) -> URL! {
        // Return URL below during development
        return URL(string: "http://localhost:8081/index.ios.bundle?platform=ios")
    }
}
