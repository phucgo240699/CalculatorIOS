//
//  Drag.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension DetailBoardViewController: UITableViewDragDelegate {
    
    func dragItem(forPhotoAt indexPath: IndexPath, tableview: UITableView) -> UIDragItem {
        print("drag for photo at")
        
        let card = CustomCard.shared.getCardsSorting(list: lists[tableview.tag], by: "id", ascending: ascendingId)[indexPath.row]
        
        var string = String()
        string = card.titleCard ?? ""
        
        let itemProvider = NSItemProvider(object: string as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        startDragCardIndex = indexPath.row
        startDragList = lists[tableview.tag]
        startDragTable = tableview
        
        return dragItem
    }
    
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        print("items for beginning session")
        let dragItem = self.dragItem(forPhotoAt: indexPath, tableview: tableView)
        return [dragItem]
    }


}
