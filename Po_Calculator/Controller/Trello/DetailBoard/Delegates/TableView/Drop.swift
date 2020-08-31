//
//  Drop.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension DetailBoardViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath

        }
        else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            
            
            // Get Destination's IndexPath
            let indexPathDes = IndexPath(row: destinationIndexPath.row, section: destinationIndexPath.section)

            guard let startDragCardIndex = self.startDragCardIndex, let startDragList = self.startDragList else {
                return
            }
            
            // Get Cards
            let cards = CustomCard.shared.getCardsSorting(list: self.lists[tableView.tag], by: "id", ascending: self.ascendingId)
            let count = cards.count
            
            if (indexPathDes.row > count - 1) {
                CustomCard.shared.moveCardIdToAnotherList(fromIndex: startDragCardIndex, toIndex: indexPathDes.row, fromList: startDragList, toList: self.lists[tableView.tag], isAbove: false)
                
            }
            else {
                CustomCard.shared.moveCardIdToAnotherList(fromIndex: startDragCardIndex, toIndex: indexPathDes.row, fromList: startDragList, toList: self.lists[tableView.tag], isAbove: true)
            }
            
            guard let board = self.board else {
                return
            }
            
            self.lists = CustomList.shared.getListsSorting(board: board, by: "id", ascending: true)

            DispatchQueue.main.async {
                let cell1 = self.collectionView?.cellForItem(at: IndexPath(row: Int(startDragList.id), section: 0))
                let cell2 = self.collectionView?.cellForItem(at: IndexPath(row: Int(tableView.tag), section: 0))
                
                if cell1 != nil {
                    (cell1 as! ListCollectionViewCell).tableView.reloadData() //updateTableView(tableView: &(cell1 as! ListCollectionViewCell).tableView)
                }
                if cell2 != nil {
                    (cell2 as! ListCollectionViewCell).tableView.reloadData() //self.updateTableView(tableView: &(cell2 as! ListCollectionViewCell).tableView)
                }
                if cell1 == nil {
                    self.startDragTable?.reloadData()
                    self.startDragTable = nil
                }
            }


        }
    }



    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
}
