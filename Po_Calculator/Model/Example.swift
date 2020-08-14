//
//  Example.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/13/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct Example: Codable {
    var name: String?
    var dob: String?
    var company: String?
    var address: String?
    var founded: String?
    var co_founders: [String]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case dob
        case company
        case address
        case founded
        case co_founders = "co-founders"
    }
}
