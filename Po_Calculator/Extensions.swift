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
}

infix operator <- : AssignmentPrecedence
extension Array where Element == Example {
    static func <- (left: inout Array, right: Element) {
        left.append(right)
    }
}
