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

//    func addCards(cards: [Card], list: List) {
//        do {
//            self.cards.append(contentsOf: cards)
//
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
    
    func addCard(title: String, description: String, list: List) {
        do {
            let numbersOfCard = try context.fetch(Card.fetchRequest()).count
            
            let newCard = Card(context: context)
            newCard.id = Int64(numbersOfCard)
            newCard.isDone = false
            newCard.titleCard = title
            newCard.descriptionCard = description
            newCard.list = list
        
            try context.save()
        } catch {
            print(error)
        }
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
            let cards: [Card] = try context.fetch(Card.fetchRequest())
            
            cards[index].titleCard = title
            cards[index].descriptionCard = description
            cards[index].isDone = isDone
        
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteCard(index: Int){
        do {
            let cards: [Card] = try context.fetch(Card.fetchRequest())
            
            // Scan CheckList
            let requestCheckList: NSFetchRequest = CheckList.fetchRequest()
            requestCheckList.predicate = NSPredicate(format: "card == %@", cards[index])
            let checkListsOfCard = try context.fetch(requestCheckList)
                
            for checkList in checkListsOfCard {
                context.delete(checkList)
            }
            
            // Delete Card
            context.delete(cards[index])
            
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    func swapCardID(fromIndex: Int, toIndex: Int) {
        do{
            let cards: [Card] = try context.fetch(Card.fetchRequest())
            
            let fromId = cards[fromIndex].id
            let toId = cards[toIndex].id
            
            cards[fromIndex].id = toId
            cards[toIndex].id = fromId
        
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func moveCardToAnotherList(index: Int, destinationList: List) {
        do {
            let cards: [Card] = try context.fetch(Card.fetchRequest())
            
            cards[index].list = destinationList
            try context.save()
        } catch {
            print(error)
        }
    }
}

