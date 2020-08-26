//
//  CustomBoard.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/24/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CustomBoard {
    static let shared = CustomBoard()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func addBoard(thumbnail: String, title: String) {
        do {
            let numbersOfBoard = try context.fetch(Board.fetchRequest()).count
            
            let newBoard = Board(context: context)
            newBoard.thumbnail = thumbnail
            newBoard.title = title
            newBoard.id = Int64(numbersOfBoard)
        
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getBoardsSorting(by field: String, ascending: Bool) -> [Board] {
        do {
            let request: NSFetchRequest = Board.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: field, ascending: ascending)
            request.sortDescriptors = [sortDescriptor]
            
            return try context.fetch(request)
        } catch {
            print(error)
        }
        return []
    }
    
    func updateBoard(index: Int, thumbnail: String, title: String){
        do {
            let boards: [Board] = try context.fetch(Board.fetchRequest())
            
            boards[index].thumbnail = thumbnail
            boards[index].title = title
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteBoard(index: Int){
        do {
            let boards: [Board] = try context.fetch(Board.fetchRequest())
            
            // Scan List
            let requestList: NSFetchRequest = List.fetchRequest()
            requestList.predicate = NSPredicate(format: "board == %@", boards[index])
            let listsOfBoard = try context.fetch(requestList)
            
            for list in listsOfBoard {
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
                context.delete(list)
            }
            
            // Delete Board
            context.delete(boards[index])
            
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    func swapBoardID(fromIndex: Int, toIndex: Int) {
        do {
            let boards: [Board] = try context.fetch(Board.fetchRequest())
            let fromId = boards[fromIndex].id
            let toId = boards[toIndex].id
            
            boards[fromIndex].id = toId
            boards[toIndex].id = fromId
        
            try context.save()
        } catch {
            print(error)
        }
    }
}
