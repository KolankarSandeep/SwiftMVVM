//
//  UIButtonExtention.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//


import UIKit

extension UIButton {
    func configure(_ cornerRadius: CGFloat, borderColor: UIColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
}
