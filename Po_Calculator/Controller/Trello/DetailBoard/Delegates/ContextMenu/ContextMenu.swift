//
//  ContextMenu.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension DetailBoardViewController {

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                
                guard let board = self.board else {
                    return
                }
                CustomList.shared.deleteList(index: indexPath.row, board: board)
                self.lists = CustomList.shared.getListsSorting(board: board, by: "id", ascending: true)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        
        return configuration
    }
//    
//    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
//            
//            let delete = UIAction(title: "Deleting", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
//                print("Deleting from tableView ...")
//            }
//            let edit = UIAction(title: "Editing", image: UIImage(systemName: "slider.horizontal.3")) { _ in
//                
//                tableView.isEditing = !tableView.isEditing
//                
//            }
//            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete, edit])
//        }
//        
//        return configuration
//    }
//    
//    
}
