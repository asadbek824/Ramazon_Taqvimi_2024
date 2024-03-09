//
//  UIColor.swift
//  Ramazon Taqvimi 2024
//
//  Created by islombek on 16/02/24.
//

import UIKit

//MARK: - extention to UIColor
extension UIColor {
    static var appColor = AppColor()
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static func rgbAll(_ value: CGFloat) -> UIColor {
        UIColor(red: value/255, green: value/255, blue: value/255, alpha: 1)
    }
}
struct AppColor {
    let primary: UIColor = .rgb(193, 202, 171)
    let textColor: UIColor = .rgb(0, 100, 0)
    let timerColor: UIColor = .rgb(222, 248, 150)
    let manocolor: UIColor = .rgb(36, 37, 38)
    let openclose: UIColor = .rgb(43, 56, 0)
}
