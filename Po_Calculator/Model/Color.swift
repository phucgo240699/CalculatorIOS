//
//  Color.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/22/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

enum Color {
    case red
    case pink
    case organe
    case yellow
    case green
    case blue
    case purple
    case silver
    case black
    
    
    func toUIColor() -> UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .pink:
            return UIColor.systemPink
        case .organe:
            return UIColor.orange
        case .yellow:
            return UIColor.yellow
        case .green:
            return UIColor.green
        case .blue:
            return UIColor.blue
        case .purple:
            return UIColor.purple
        case .silver:
            return UIColor.lightGray
        default:
            return UIColor.black
        }
    }
    
    func toString() -> String {
        switch self {
        case .red:
            return "red"
        case .pink:
            return "pink"
        case .organe:
            return "orange"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        case .blue:
            return "blue"
        case .purple:
            return "purple"
        case .silver:
            return "silver"
        default:
            return "black"
        }
    }
        
}


class ListColor {
    static let colors: [Color] = [.red, .pink, .organe, .yellow, .green, .blue, .purple, .silver]
}
