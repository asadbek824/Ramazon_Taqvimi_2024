//
//  UIColor.swift
//  Ramazon Taqvimi 2024
//
//  Created by Asadbek Yoldoshev on 15/02/24.
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
    let navigatioColor: UIColor = .rgb(100, 114, 97)
    let tabBarColor: UIColor = .rgb(100, 114, 97)
    let tabBarTintColor: UIColor = .rgb(28, 69, 18)
    let navigationBarTintColor: UIColor = .rgb(0, 51, 0)
    let arablabel: UIColor = .rgb(0, 35, 119)
    let countcolor: UIColor = .rgb(177, 199, 148)
}
