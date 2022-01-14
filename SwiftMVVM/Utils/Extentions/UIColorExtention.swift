//
//  Extentions.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//


import UIKit

extension UIColor {
    static func buttonBorderColor() -> UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                // the color can be from your own color config struct as well.
                return trait.userInterfaceStyle == .dark ? UIColor.systemBlue: UIColor.clear
            }
        } else { return UIColor.clear }
    }
}
