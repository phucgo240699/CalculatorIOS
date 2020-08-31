//
//  CustomList.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/24/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CustomList {
    static let shared = CustomList()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func addList(name: String, board: Board) {
        do {
            let request: NSFetchRequest = List.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "board == %@", board)
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.predicate = predicate
            request.sortDescriptors = [sortDescriptor]
            
            let lists = try context.fetch(request)
            let count = lists.count
            
            let newList = List(context: context)
            newList.name = name
            newList.id = count > 0 ? lists[count - 1].id + 1: 0
            newList.board = board
        
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getList(board: Board, by index: Int) -> List? {
        var list: List?
        do {
            let request: NSFetchRequest = List.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            list = (try context.fetch(request))[index]
            
        } catch {
            print(error)
        }
        
        return list
    }
    
    func getListsSorting(board: Board, by field: String, ascending: Bool) -> [List] {
        do {
            let request: NSFetchRequest = List.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "board == %@", board)
            let sortDescriptor = NSSortDescriptor(key: field, ascending: ascending)
            request.predicate = predicate
            request.sortDescriptors = [sortDescriptor]
            
            return try context.fetch(request)
        } catch {
            print(error)
        }
        return []
    }
    
    func updateList(index: Int, board: Board, name: String){
        do {
            let request: NSFetchRequest = List.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "board == %@", board)
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            
            request.sortDescriptors = [sortDescriptor]
            request.predicate = predicate
            
            let list: List = try context.fetch(request)[index]
            
            list.name = name
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteList(index: Int, board: Board){
        do {
            let request: NSFetchRequest = List.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "board == %@", board)
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            request.predicate = predicate
            
            let list: List = try context.fetch(request)[index]
            
            // Scan Card
            let requestCard: NSFetchRequest = Card.fetchRequest()
            requestCard.predicate = NSPredicate(format: "list == %@", list)
            let cardsOfList = try context.fetch(requestCard)
            
            for card in cardsOfList {
                // Scan CheckList
                let requestCheckList: NSFetchRequest = CheckList.fetchRequest()
                requestCheckList.predicate = NSPredicate(format: "card == %@", card)
                let checkListsOfCard = try context.fetch(requestCheckList)
                
                for checkList in checkListsOfCard {
                    context.delete(checkList)
                }
                context.delete(card)
            }
            
            // Delete List
            context.delete(list)
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
//    func swapListID(fromIndex: Int, toIndex: Int, board: Board) {
//        do {
//
//            let request1: NSFetchRequest = List.fetchRequest()
//            let pre1: NSPredicate = NSPredicate(format: "board == %@", board)
//            let sortDescriptor1 = NSSortDescriptor(key: "id", ascending: true)
//
//            request1.sortDescriptors = [sortDescriptor1]
//            request1.predicate = pre1
//
//
//
//
//
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
}

