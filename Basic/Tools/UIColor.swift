//
//  UIColor.swift
//  RelaxApp
//
//  Created by Honglin Yi on 2/20/18.
//  Copyright © 2018 Honglin Yi. All rights reserved.
//

import Foundation
import UIKit

///Custom colors: primary, collectionBorder, lightBackgroud, elegantGreen
public extension UIColor {
    
    /**
     Init rgb number, begin with "0x"
     */
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    
    ///quite red
    static public let hyPrimary = UIColor(rgb:0xF24253)
    
    ///quite gray
    static public let hyCollectionBorder = UIColor(red: 174.0/255.0, green: 177.0/255.0, blue: 181.0/255.0, alpha: 1.0)
    
    ///quite white
    static public let hyLightBackgroud = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0)
    
    ///quite green
    static public let hyElegantGreen = UIColor(red: 120.0/255.0, green: 202.0/255.0, blue: 174.0/255.0, alpha: 1.0)
    
    static public let hyRed = UIColor(rgb: 0xffa4a2)
    static public let hyPink = UIColor(rgb: 0xff94c2)
    static public let hyPurple = UIColor(rgb: 0xee98fb)
    static public let hyViolet = UIColor(rgb: 0xc7a4ff)
    static public let hyIndigo = UIColor(rgb: 0xaab6fe)
    static public let hyBlue = UIColor(rgb: 0x9be7ff)
    static public let hyCyan = UIColor(rgb: 0x88ffff)
    static public let hyGreen = UIColor(rgb: 0xb2fab4)
    static public let hyAmber = UIColor(rgb: 0xfffd61)
}
