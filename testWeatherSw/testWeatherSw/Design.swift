//
//  Design.swift
//  testWeatherSw
//
//  Created by FE Team TV on 5/26/16.
//  Copyright © 2016 courses. All rights reserved.
//

import Foundation

extension UIFont{
    
    static func HelTextFont(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "HelveticaNeue", size: size)!
    }
}

extension UIColor{
    // Creates a UIColor from a Hex string.
    convenience init(hexString: String) {
        var cString: String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            self.init(white: 0.5, alpha: 1.0)
        } else {
            let rString: String = (cString as NSString).substring(to: 2)
            let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
            let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
            
            var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
            Scanner(string: rString).scanHexInt32(&r)
            Scanner(string: gString).scanHexInt32(&g)
            Scanner(string: bString).scanHexInt32(&b)
            
            self.init(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: CGFloat(1))
        }
    }
    
    static func backGroundColor() -> UIColor {
        return UIColor.black
    }
    
    static func sepColor() -> UIColor {
        return UIColor.yellow
    }
    
    static func mainTextColor() -> UIColor {
        return UIColor.blue
    }
    static func onBlackTextColor() -> UIColor {
        return UIColor.white
    }
    static func oneCellColor() -> UIColor {
        return UIColor.white
    }
    static func twoCellColor() -> UIColor {
        return UIColor.gray
    }
    static func hexBorderColor() -> String {
        return "#f1c40f"
    }
}


// MARK: - UITextField
extension UITextField  {
    func setBorder() {
        
        self.borderStyle = UITextBorderStyle.none;
        let width = CGFloat(1.0)
        self.layer.borderColor =  UIColor(hexString: UIColor.hexBorderColor()).cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
    
}

