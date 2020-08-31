//
//  TableView.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/28/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension DetailBoardViewController : UITableViewDelegate, UITableViewDataSource {
    
    //
    // Custom Footer
    //
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.bounds.width * 0.2))
//        footerView.backgroundColor = .green
        
        let addCardBtn = UIButton()
        footerView.addSubview(addCardBtn)
        addCardBtn.frame = footerView.bounds
        //addCardBtn.titleLabel?.font.fontName ??
        addCardBtn.setTitle("+ Add Card", for: .normal)
        addCardBtn.titleLabel?.font = UIFont(name:  "Helvetica Neue", size: addCardBtn.bounds.height * 0.5)
        addCardBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
        addCardBtn.addTarget(self, action: #selector(self.addCard(sender:)) , for: .touchUpInside)
        addCardBtn.tag = tableView.tag // Important to recognize button
        
        return footerView
    }
    
    
    // Height footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView.bounds.width * 0.2 //UIDevice.current.userInterfaceIdiom == .pad ? 60.0 : 30.0
    }
    
    @objc func addCard(sender: UIButton) {
        var alert: UIAlertController? = UIAlertController(title: "Create new card", message: "", preferredStyle: .alert)
        
        
        var textField: UITextField? = UITextField()
        var descriptionTextField: UITextField? = UITextField()
        
        var okAction: UIAlertAction? = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            if  let text = textField?.text, let description = descriptionTextField?.text, let _ = self.board {
                if text.isEmptyOrSpaceing() == false {
                    CustomCard.shared.addCard(title: text, description: description, list: self.lists[sender.tag])
                    
                    
                    //DispatchQueue.main.async {
//                        (self.collectionView?.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! ListCollectionViewCell).tableView.reloadData()
                        self.updateTableView(tableView: &(self.collectionView?.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! ListCollectionViewCell).tableView)
                    //}
                    //self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
        
        let cancelAction: UIAlertAction? = UIAlertAction(title: "Cancel", style: .default) { (action) in
            textField = nil
            okAction = nil
            alert = nil
            
        }
        
        guard let alertConstant = alert, let okActionConstant = okAction, let cancelActionConstant = cancelAction else {
            return
        }
        
        alertConstant.addAction(okActionConstant)
        alertConstant.addAction(cancelActionConstant)
        alertConstant.addTextField { (alertTextField) in
            alertTextField.placeholder = "Typing title of new card"
            textField = alertTextField
        }
        alertConstant.addTextField { (alertTextField) in
            alertTextField.placeholder = "Typing description of new card"
            descriptionTextField = alertTextField
        }
        
        present(alertConstant, animated: true, completion: nil)
    }
    
    //
    // Height Header
    //
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.bounds.width * 0.25 // UIDevice.current.userInterfaceIdiom == .pad ? 60.0 : 30.0
    }
    
    
    
    //
    // Custom Header
    //
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.bounds.width * 0.2))
        let width = headerView.bounds.width
        let height = headerView.bounds.height
//        headerView.backgroundColor = .red
        let listNameLbl = UILabel()
        headerView.addSubview(listNameLbl)
//        listNameLbl.frame = headerView.bounds
        listNameLbl.frame = CGRect(x: width * 0.1, y: 0, width: width * 0.7, height: height)
        
        listNameLbl.text = lists[tableView.tag].name
        listNameLbl.font = UIFont(name: "Helvetica Neue" , size: listNameLbl.bounds.height * 0.5)
        listNameLbl.textAlignment = .left
        
        let menuBtn = UIButton()
        headerView.addSubview(menuBtn)
        menuBtn.frame = CGRect(x: width * 0.8, y: 0, width: width * 0.2, height: height)
        menuBtn.setImage(UIImage(systemName: "list.number"), for: .normal)
        menuBtn.setTitleColor(UIColor.darkGray, for: .normal)

        menuBtn.tag = tableView.tag
        menuBtn.addTarget(self, action: #selector(self.showMenuList(sender:)), for: .touchUpInside)
        print(lists[tableView.tag].name)
        return headerView
    }
    
    @objc func showMenuList (sender: UIButton) {
        //performSegue(withIdentifier: "gotoSetting", sender: self)
        let tableView = (collectionView?.cellForItem(at: IndexPath(row: sender.tag, section: 0)) as! ListCollectionViewCell).tableView
        
        if let tableView = tableView {
            tableView.isEditing = !tableView.isEditing
        }
    }
    
    
    
    //
    // Number of Rows
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomCard.shared.getCardsSorting(list: lists[tableView.tag], by: "id", ascending: ascendingId).count
    }

    // Custom Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardTableViewCell
        print("cell for row: \(lists[tableView.tag].name)")
        guard let lbl = cell.cardNameLbl else {
            return UITableViewCell()
        }
        
        let cards = CustomCard.shared.getCardsSorting(list: lists[tableView.tag], by: "id", ascending: ascendingId)
        
        if cards.count > 0 {
            lbl.text = cards[indexPath.row].titleCard
        }

        return cell
    }

    //
    // Did select
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCardVC = DetailCardViewController()
        detailCardVC.modalPresentationStyle = .fullScreen
        
        let card = CustomCard.shared.getCard(list: lists[tableView.tag], by: indexPath.row)
        
        detailCardVC.navigationItem.title = card?.titleCard
        detailCardVC.board = board
        detailCardVC.list = lists[tableView.tag]
        detailCardVC.card = card
        
        selectedList = lists[tableView.tag]
        
        self.present(detailCardVC, animated: true, completion: nil)
        
    }
    
    //
    // Delete
    //
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CustomCard.shared.deleteCard(index: indexPath.row, list: lists[tableView.tag])
        }
    }
    
    //
    // Re ordering
    //
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
//        let cards = CustomCard.shared.getCardsSorting(list: lists[tableView.tag], by: "id", ascending: true)
        
        CustomCard.shared.swapCardID(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
        
        DispatchQueue.main.async {
            (self.collectionView?.cellForItem(at: IndexPath(row: tableView.tag, section: 0)) as! ListCollectionViewCell).tableView.reloadData()
        }
    }
}
