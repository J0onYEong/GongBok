//
//  Color.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/14.
//

import SwiftUI

extension UIColor {
    convenience init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        guard hexString.count == 6 else {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


extension ShapeStyle where Self == Color {
    static var correctAnswer: Color {
        Color(uiColor: UIColor(hex: "6B83FF")!)
    }
    static var background: Color {
        Color(uiColor: UIColor(hex: "DEDEDE")!)
    }
    static var starColor: Color {
        Color(uiColor: UIColor(hex: "FFD626")!)
    }
    static var refuse: Color {
        Color(uiColor: UIColor(hex: "FFA5A5")!)
    }
    static var underBar: Color {
        Color(uiColor: UIColor(hex: "D7CCBD")!)
    }
    static var submit: Color {
        Color(uiColor: UIColor(hex: "F1F1F1")!)
    }
    static var accept: Color {
        Color(uiColor: UIColor(hex: "8AE08E")!)
    }
    static var notification: Color {
        Color(uiColor: UIColor(hex: "FF7575")!)
    }
    static var levelBar: Color {
        Color(uiColor: UIColor(hex: "166ACC")!)
    }
    static var tabViewAccent: Color {
        Color(uiColor: UIColor(hex: "FAFF03")!)
    }
    static var gradient1: Color {
        Color(uiColor: UIColor(hex: "EEFFA9")!)
    }
    static var gradient2: Color {
        Color(uiColor: UIColor(hex: "166ACC")!)
    }
    static var settingColor1: Color {
        Color(uiColor: UIColor(hex: "#F1E5D5")!)
    }
}
