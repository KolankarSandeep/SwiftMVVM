//
//  Int.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 14/01/22.
//

import UIKit

extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
