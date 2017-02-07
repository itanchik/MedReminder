//
//  UIColor.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 06/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    class func pink() -> UIColor{
        return self.hexStringToUIColor(hex: "#F4005E")
    }
    
    class func unselectedPink() -> UIColor{
        return self.hexStringToUIColor(hex: "#EA86AD")
    }
    
    class func green() -> UIColor{
        return self.hexStringToUIColor(hex: "#4CDA60")
    }
    
    class func yellow() -> UIColor{
        return self.hexStringToUIColor(hex: "#F5A623")
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
