//
//  Colors.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 05.06.2021.
//

import UIKit

extension UIColor {
    
    // MARK: - BG COLORS
    static var profileBgColor = UIColor(rgb: 0x5c3c92)
    static var groupsBgColor = UIColor(rgb: 0x077b8a)
    static var chatsBgColor = UIColor(rgb: 0x12a4d9)
    static var friendsBgColor = UIColor(rgb: 0xfbcbc9)
    static var settingsBgColor = UIColor(rgb: 0xef9d10f)
    
    // MARK: - GRADIENT COLORS
    static var gradientColorTop = toRGB(red: 246, green: 54, blue: 105)
    static var gradientColorBottom = toRGB(red: 90, green: 52, blue: 169)

    static func toRGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: (rgb) & 0xFF
        )
    }
}
