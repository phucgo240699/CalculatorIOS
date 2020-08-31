//
//  CollectionView.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension DetailBoardViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //
    // Size Item
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  view.bounds.width * 0.5 , height: collectionView.bounds.height * 0.8)
    }
    
    //
    // Items
    //
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }

    //
    // Custom Item
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCollectionViewCell
        
        guard let tableView = cell.tableView else {
            return ListCollectionViewCell()
        }
        
        let cards = CustomCard.shared.getCardsSorting(list: lists[indexPath.row], by: "id", ascending: true)
        
        cell.frame.size.height = CGFloat(cards.count) * tableView.rowHeight + cell.bounds.width * 0.45
        tableView.tag = indexPath.row
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "cardCell")
        tableView.separatorStyle = .none//        if let index = indexOfTableViewNeedReload {
//            if tableView.tag == index {
//                indexOfTableViewNeedReload = nil
//                self.updateTableView(tableView: &tableView)
//            }
//        }
        
        return cell
    }
}

