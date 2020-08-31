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
            let request: NSFetchRequest = Board.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            
            let boards: [Board] = try context.fetch(request)
            let count = boards.count
            
            let newBoard = Board(context: context)
            newBoard.thumbnail = thumbnail
            newBoard.title = title
            newBoard.id = count > 0 ? boards[count-1].id + 1 : 0
        
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getBoardById (id: Int64) -> Board? {
        do {
            let request: NSFetchRequest = Board.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "id == %@", id)
            request.predicate = predicate
            
            return (try context.fetch(request))[0]
        } catch {
            print(error)
        }
        return nil
    }
    
    func getBoard(by index: Int) -> Board? {
        var board: Board?
        do {
            let request: NSFetchRequest = Board.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            board = (try context.fetch(request))[index]
            
        } catch {
            print(error)
        }

        return board
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
            let request: NSFetchRequest = Board.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            
            let board: Board = (try context.fetch(request))[index]
            
            board.thumbnail = thumbnail
            board.title = title
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteBoard(index: Int){
        do {
            let request: NSFetchRequest = Board.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            let board: Board = (try context.fetch(request))[index]
            
            // Scan List
            let requestList: NSFetchRequest = List.fetchRequest()
            requestList.predicate = NSPredicate(format: "board == %@", board )
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
            context.delete(board)
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func swapBoardID(fromIndex: Int, toIndex: Int) {
        do {
            let request1: NSFetchRequest = Board.fetchRequest()
            let sortDescriptor1 = NSSortDescriptor(key: "id", ascending: true)
            request1.sortDescriptors = [sortDescriptor1]
            
            let request2: NSFetchRequest = Board.fetchRequest()
            let sortDescriptor2 = NSSortDescriptor(key: "id", ascending: true)
            request2.sortDescriptors = [sortDescriptor2]
            
            
            
            let sourceBoard = try context.fetch(request1)[fromIndex]
            let desBoard = try context.fetch(request2)[toIndex]
            
            let tempId = sourceBoard.id
            sourceBoard.id = desBoard.id
            desBoard.id = tempId
            
        
            try context.save()
        } catch {
            print(error)
        }
    }
}
