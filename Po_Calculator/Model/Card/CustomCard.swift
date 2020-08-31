//
//  CustomCard.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/24/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CustomCard {
    static let shared = CustomCard()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func addCard(title: String, description: String, list: List) {
        do {
            let request: NSFetchRequest = Card.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "list == %@", list)
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.predicate = predicate
            request.sortDescriptors = [sortDescriptor]
            
            let cards = try context.fetch(request)
            let count = cards.count
            
            let newCard = Card(context: context)
            newCard.id = count > 0 ? cards[count - 1].id + 1 : 0
            newCard.isDone = false
            newCard.titleCard = title
            newCard.descriptionCard = description
            newCard.list = list
        
            try context.save()
        } catch {
            print(error)
        }
    }

    func getCard(list: List, by index: Int) -> Card? {
        do {
            let request: NSFetchRequest = Card.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "list == %@ && id == %@", argumentArray: [list, Int64(index)])
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            request.predicate = predicate
            
            return try context.fetch(request)[index]
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getCardsSorting(list: List, by field: String, ascending: Bool) -> [Card] {
        do {
            let request: NSFetchRequest = Card.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "list == %@", list)
            let sortDescriptor = NSSortDescriptor(key: field, ascending: ascending)
            request.predicate = predicate
            request.sortDescriptors = [sortDescriptor]
            
            return try context.fetch(request)
        } catch {
            print(error)
        }
        return []
    }
    
    func updateCard(index: Int, title: String, description: String, isDone: Bool, list: List){
        do {
            let request: NSFetchRequest = Card.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "list == %@", list)
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            
            request.sortDescriptors = [sortDescriptor]
            request.predicate = predicate
            
            let card: Card = try context.fetch(request)[index]
            
            card.titleCard = title
            card.descriptionCard = description
            card.isDone = isDone
        
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteCard(index: Int, list: List){
        do {
            let request: NSFetchRequest = Card.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: "list == %@", list)
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            
            request.sortDescriptors = [sortDescriptor]
            request.predicate = predicate
            
            let card: Card = try context.fetch(request)[index]
            
            // Scan CheckList
            let requestCheckList: NSFetchRequest = CheckList.fetchRequest()
            requestCheckList.predicate = NSPredicate(format: "card == %@", card)
            let checkListsOfCard = try context.fetch(requestCheckList)
                
            for checkList in checkListsOfCard {
                context.delete(checkList)
            }
            
            // Delete Card
            context.delete(card)
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    func moveCardIdToAnotherList(fromIndex: Int, toIndex: Int, fromList: List, toList: List, isAbove: Bool) {
        do{
            let request1: NSFetchRequest = Card.fetchRequest()
            let predicate1 = NSPredicate(format: "list == %@", fromList)
            let sortDescriptor1 = NSSortDescriptor(key: "id", ascending: true)
            request1.sortDescriptors = [sortDescriptor1]
            request1.predicate = predicate1
            
            let request2: NSFetchRequest = Card.fetchRequest()
            let predicate2 = NSPredicate(format: "list == %@", toList)
            let sortDescriptor2 = NSSortDescriptor(key: "id", ascending: true)
            request2.sortDescriptors = [sortDescriptor2]
            request2.predicate = predicate2
            
            let sourceCards = try context.fetch(request1)
            let sourceCard = sourceCards[fromIndex]
            
            let desCards = try context.fetch(request2)
            let count = desCards.count
            
            // Situation destination cards is empty
            if count <= 0 {
                sourceCard.id = 0
                sourceCard.list = toList
                
                // Setup source cards id after move to another list
                let request: NSFetchRequest = Card.fetchRequest()
                let predicate = NSPredicate(format: "list == %@", fromList)
                let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
                request.sortDescriptors = [sortDescriptor]
                request.predicate = predicate
                
                let sourceCardsAfterMove = try context.fetch(request)
                
                for i in 0..<sourceCardsAfterMove.count {
                    sourceCardsAfterMove[i].id = Int64(i)
                }
                
                try context.save()
                return
            }
            
            
            
            if (isAbove) {
                let desCard = desCards[toIndex]
                sourceCard.id = desCard.id
                
                let range = desCard.id ... desCards[count - 1].id
                for i in range {
                    desCards[Int(i)].id = Int64(i+1)
                }
            }
            else {
                sourceCard.id = desCards[count-1].id + 1
            }
            sourceCard.list = toList
            
            
            
            // Setup source cards id after move to another list
            let request: NSFetchRequest = Card.fetchRequest()
            let predicate = NSPredicate(format: "list == %@", fromList)
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            request.predicate = predicate
            
            let sourceCardsAfterMove = try context.fetch(request)
            
            for i in 0..<sourceCardsAfterMove.count {
                sourceCardsAfterMove[i].id = Int64(i)
            }
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func swapCardID(fromIndex: Int, toIndex: Int) {
        do {
            let request1: NSFetchRequest = Card.fetchRequest()
            let sortDescriptor1 = NSSortDescriptor(key: "id", ascending: true)
            request1.sortDescriptors = [sortDescriptor1]
            
            let request2: NSFetchRequest = Card.fetchRequest()
            let sortDescriptor2 = NSSortDescriptor(key: "id", ascending: true)
            request2.sortDescriptors = [sortDescriptor2]
            
            
            
            let sourceCard = try context.fetch(request1)[fromIndex]
            let desCard = try context.fetch(request2)[toIndex]
            
            let tempId = sourceCard.id
            sourceCard.id = desCard.id
            desCard.id = tempId
            
            try context.save()
        } catch {
            print(error)
        }
    }

}

