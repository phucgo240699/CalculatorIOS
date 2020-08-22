//
//  Extensions.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/12/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func include (_ character: Character) -> Bool {
        for e in self {
            if e == character {
                return true
            }
        }
        return false
    }
    
    func toColor() -> Color {
        
        if self == "red" {
            return .red
        }
        else if self == "pink" {
            return .pink
        }
        else if self == "orange" {
            return .organe
        }
        else if self == "yellow" {
            return .yellow
        }
        else if self == "green" {
            return .green
        }
        else if self == "blue" {
            return .blue
        }
        else if self == "purple" {
            return .purple
        }
        else if self == "silver" {
            return .silver
        }
        return .black
    }
}

infix operator <- : AssignmentPrecedence
extension Array where Element == Example {
    static func <- (left: inout Array, right: Element) {
        left.append(right)
    }
}
