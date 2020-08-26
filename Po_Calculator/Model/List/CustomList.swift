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
            let numbersOfList = try context.fetch(List.fetchRequest()).count
            
            let newList = List(context: context)
            newList.name = name
            newList.id = Int64(numbersOfList)
            newList.board = board
        
            try context.save()
        } catch {
            print(error)
        }
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
    
    func updateList(index: Int, name: String){
        do {
            let lists: [List] = try context.fetch(List.fetchRequest())
            
            lists[index].name = name
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteList(index: Int){
        do {
            let lists: [List] = try context.fetch(List.fetchRequest())
            
            // Scan Card
            let requestCard: NSFetchRequest = Card.fetchRequest()
            requestCard.predicate = NSPredicate(format: "list == %@", lists[index])
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
            context.delete(lists[index])
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func swapListID(fromIndex: Int, toIndex: Int) {
        do {
            let lists: [List] = try context.fetch(List.fetchRequest())
            let fromId = lists[fromIndex].id
            let toId = lists[toIndex].id
            
            lists[fromIndex].id = toId
            lists[toIndex].id = fromId
        
            try context.save()
        } catch {
            print(error)
        }
    }
}

