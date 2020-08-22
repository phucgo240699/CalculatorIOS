//
//  Board+CoreDataProperties.swift
//  
//
//  Created by Phúc Lý on 8/22/20.
//
//

import Foundation
import CoreData


extension Board {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Board> {
        return NSFetchRequest<Board>(entityName: "Board")
    }

    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?

}
