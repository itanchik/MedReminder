//
//  CustomTabBar.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 04/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBar {
    let kBarHeight: CGFloat = 70

    override func viewWillLayoutSubviews() {
        var tabFrame: CGRect
        tabFrame = self.tabBar.frame
        tabFrame.size.height = kBarHeight
        tabFrame.origin.y = self.view.frame.size.height - kBarHeight
        self.tabBar.frame = tabFrame
    }

}
