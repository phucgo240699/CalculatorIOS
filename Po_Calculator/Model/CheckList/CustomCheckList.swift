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
    static let shared = CustomList()
    static var checkLists: [CheckList] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func addCheckList(name: String, card: Card) {
        let newCheckList = CheckList(context: context)
        newCheckList.name = name
        newCheckList.isDone = false
        newCheckList.id = Int64(CustomCheckList.checkLists.count)
        newCheckList.card = card
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getCheckLists(card: Card) -> [CheckList] {
        do {
            return try context.fetch(CheckList.fetchRequest())
        } catch {
            print(error)
        }
        return []
    }
    
    func getCheckListsSorting(card: Card, by field: String, ascending: Bool) -> [CheckList] {
        do {
            let request: NSFetchRequest = CheckList.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "card == %@", card)
            let sortDescriptor = NSSortDescriptor(key: field, ascending: ascending)
            request.predicate = predicate
            request.sortDescriptors = [sortDescriptor]
            
            return try context.fetch(request)
        } catch {
            print(error)
        }
        return []
    }
    
    func updateCheckList(index: Int, name: String, isDone: Bool, card: Card){
        CustomCheckList.checkLists[index].name = name
        CustomCheckList.checkLists[index].isDone = isDone
        CustomCheckList.checkLists[index].card = card
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteCheckList(index: Int){
        context.delete(CustomCheckList.checkLists[index])
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func swapCheckListID(fromIndex: Int, toIndex: Int) {
        let fromId = CustomCheckList.checkLists[fromIndex].id
        let toId = CustomCheckList.checkLists[toIndex].id
        
        CustomCheckList.checkLists[fromIndex].id = toId
        CustomCheckList.checkLists[toIndex].id = fromId
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

