//
//  CustomCheckList.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/24/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CustomCheckList {
//    static let shared = CustomList()
//    static var checkLists: [CheckList] = []
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    func addCheckList(name: String, card: Card) {
//        do {
//            let request: NSFetchRequest = Card.fetchRequest()
//            let predicate: NSPredicate = NSPredicate(format: "card == %@", card)
//            request.predicate = predicate
//            
//            let checkLists = try context.fetch(request)
//            let count = checkLists.count
//            
//            let newCheckList = CheckList(context: context)
//            newCheckList.name = name
//            newCheckList.isDone = false
//            newCheckList.id = count > 0 ? checkLists[count - 1] : 0
//            newCheckList.card = card
//        
//        
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
//    
//    func getCheckList(card: Card, id: Int64) -> CheckList? {
//        do {
//            let request: NSFetchRequest = CheckList.fetchRequest()
//            let predicate: NSPredicate = NSPredicate(format: "card == %@ && id == %@", [card, id])
//            
//            request.predicate = predicate
//            
//            return try context.fetch(request)[0]
//        } catch {
//            print(error)
//        }
//        return nil
//    }
//    
//    func getCheckListsSorting(card: Card, by field: String, ascending: Bool) -> [CheckList] {
//        do {
//            let request: NSFetchRequest = CheckList.fetchRequest()
//            let predicate: NSPredicate = NSPredicate(format: "card == %@", card)
//            let sortDescriptor = NSSortDescriptor(key: field, ascending: ascending)
//            request.predicate = predicate
//            request.sortDescriptors = [sortDescriptor]
//            
//            return try context.fetch(request)
//        } catch {
//            print(error)
//        }
//        return []
//    }
//    
//    func updateCheckList(id: Int64, name: String, isDone: Bool, card: Card){
//        do {
//            let request: NSFetchRequest = CheckList.fetchRequest()
//            let predicate: NSPredicate = NSPredicate(format: "card == %@ && id == %@", [card, id])
//            request.predicate = predicate
//            
//            let checkList: CheckList = try context.fetch(request)[0]
//            
//            checkList.name = name
//            checkList.isDone = isDone
//            
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
//    
//    func deleteCheckList(card: Card, id: Int64){
//        do {
//            let request: NSFetchRequest = Card.fetchRequest()
//            let predicate: NSPredicate = NSPredicate(format: "card == %@ && id == %@", [card, id])
//            request.predicate = predicate
//            
//            let checkList = try context.fetch(request)[0]
//            
//            context.delete(checkList)
//            
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
//    
//    func swapCheckListID(fromId: Int64, toId: Int64, card: Card) {
//        do{
//            let request1: NSFetchRequest = CheckList.fetchRequest()
//            let predicate1 = NSPredicate(format: "card == %@ && id == %@", [card, fromId])
//            request1.predicate = predicate1
//            
//            let request2: NSFetchRequest = CheckList.fetchRequest()
//            let predicate2 = NSPredicate(format: "card == %@ && id == %@", [card, toId])
//            request2.predicate = predicate2
//            
//            let sourceCheckList = try context.fetch(request1)[0]
//            let desCheckList = try context.fetch(request2)[0]
//            
//            let tempId = sourceCheckList.id
//            sourceCheckList.id = desCheckList.id
//            desCheckList.id = tempId
//        
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
}

