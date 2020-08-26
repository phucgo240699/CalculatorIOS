//
//  DetailBoardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/18/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import CoreData


class DetailBoardViewController: UIViewController {
    
    @IBOutlet var editBtn: UIBarButtonItem!
    
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        if pageVC.subViewControllers[pageVC.currentPageIndex].tableView.isEditing {
            pageVC.subViewControllers[pageVC.currentPageIndex].tableView.isEditing = false
            editBtn.title = "Edit"
        }
        else {
            pageVC.subViewControllers[pageVC.currentPageIndex].tableView.isEditing = true
            editBtn.title = "Done"
        }
    }
    
    @IBAction func addListBtnPressed(_ sender: UIBarButtonItem) {
        var textField: UITextField? = UITextField()
        var alert: UIAlertController? = UIAlertController(title: "Create new List", message: "", preferredStyle: .alert)
        var okAction: UIAlertAction? = UIAlertAction(title: "Ok", style: .default) { (action) in
            if let text = textField!.text, let board = self.board {
                if text.isEmptyOrSpaceing() == false {
                    CustomList.shared.addList(name: text, board: board)

                    self.lists = CustomList.shared.getListsSorting(board: board, by: "id", ascending: self.ascendingId)

                    self.viewWillAppear(true)
                }
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            textField = nil
            okAction = nil
            alert = nil
        }

        guard let alertConstant = alert, let okActionConstant = okAction else {
            return
        }

        alertConstant.addTextField { (alertTextField) in
            alertTextField.placeholder = "Typing name of new list"
            textField = alertTextField
        }

        alertConstant.addAction(okActionConstant)
        alertConstant.addAction(cancelAction)

        present(alertConstant, animated: true, completion: nil)
    }
    
    
    // Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var board: Board? {
        didSet {
            if let board = board {
                if lists.count <= 0 {
                    lists = CustomList.shared.getListsSorting(board: board, by: "id", ascending: ascendingId)
                }
            }
        }
    }
    var lists: [List] = []
    let ascendingId: Bool = true

    var pageVC = DetailBoardPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        pageVC.view.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        pageVC.view.frame.origin = CGPoint(x: 0.0, y: 0.0)

        self.view.addSubview(pageVC.view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Setup list card
        let sizeOfLists = lists.count
        var listCardVC: [ListCardViewController] = []
        for _ in 0..<sizeOfLists {
            let listCard = ListCardViewController(nibName: "ListCardViewController", bundle: nil)
            listCardVC.append(listCard)
        }

        if sizeOfLists > 0 {
            pageVC.subViewControllers = []
            pageVC.subViewControllers = listCardVC
        }

        for i in 0..<pageVC.subViewControllers.count {
            pageVC.subViewControllers[i].list = lists[i]
        }

        if let firstViewController = pageVC.subViewControllers.first {
            pageVC.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}
