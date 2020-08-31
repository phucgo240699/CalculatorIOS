//
//  DetailBoardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/18/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import CoreData


class DetailBoardViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var collectionView: UICollectionView?
    var collectionViewCellSize: CGSize = CGSize(width: 200, height: 400)
    var indexCollectionViewCell: Int = 0
    var startDragCardIndex: Int?
    var startDragList: List?
    var startDragTable: UITableView?
    var selectedList: List?
    var selectedCard: Card?
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        var textField: UITextField? = UITextField()
        var alert: UIAlertController? = UIAlertController(title: "Create new List", message: "", preferredStyle: .alert)
        var okAction: UIAlertAction? = UIAlertAction(title: "Ok", style: .default) { (action) in
            if let text = textField!.text, let board = self.board {
                if text.isEmptyOrSpaceing() == false {
                    CustomList.shared.addList(name: text, board: board)
                    self.lists = []
                    self.lists = CustomList.shared.getListsSorting(board: board, by: "id", ascending: self.ascendingId)
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let backBTN = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(DetailBoardViewController.backForWard))
        navigationItem.leftBarButtonItem = backBTN
        
        initializeCollectionView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check board
        guard board != nil else {
            return
        }
        
        // Set background of view
        if let thumbnail = board?.thumbnail {
            if include(arr: Image.names, element: thumbnail) {
                if let image = UIImage (named: thumbnail), let collectionView = collectionView {
                    let imgView = UIImageView(image: image)
                    imgView.frame = view.bounds
                    imgView.layer.masksToBounds = true
                    imgView.contentMode = .scaleAspectFill
                    
                    for i in 0 ..< view.subviews.count {
                        if type(of: view.subviews[i]) ==  UIImageView.self {
                            view.subviews[i].removeFromSuperview()
                            break
                        }
                    }
                    
                    view.insertSubview(imgView, belowSubview: collectionView)
                }
            }
            else {
                view.backgroundColor = board?.thumbnail?.toColor().toUIColor()
                
                for i in 0 ..< view.subviews.count {
                    if type(of: view.subviews[i]) ==  UIImageView.self {
                        view.subviews[i].removeFromSuperview()
                        view.reloadInputViews()
                        break
                    }
                }
            }
        }
        
        // Set name of (board, list, card), reload tableView
        if let selectedList = selectedList {
            
            (collectionView?.cellForItem(at: IndexPath(row: Int(selectedList.id), section: 0)) as! ListCollectionViewCell).tableView.reloadData()
            
            self.navigationItem.title = board?.title
            
            self.selectedList = nil
        }
    }
    
    @objc func backForWard() {
        navigationController?.popViewController(animated: true)
    }
}

// Function Support
extension DetailBoardViewController {
    func include(arr: [String], element: String) -> Bool {
        for e in arr {
            if element == e {
                return true
            }
        }
        return false
    }
    
    func updateTableView(tableView: inout UITableView) {
        let cards = CustomCard.shared.getCardsSorting(list: lists[tableView.tag], by: "id", ascending: true)
        
        let cell = collectionView?.cellForItem(at: IndexPath(row: tableView.tag, section: 0))
        
        
        if cell != nil {
            cell!.frame.size.height = CGFloat(cards.count) * tableView.rowHeight + cell!.bounds.width * 0.45
        }
        
        tableView.reloadData()
    }
    
    func initializeCollectionView() {
        // Set layout & initialize collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubview(collectionView)
        
        // Custom display of collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.9).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        collectionView.backgroundColor = .clear
        
        // Assign delegate properties & Others
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
    }
}
//----------------------------------------------------------------------




// UICollectionView Delegate
//----------------------------------------------------------------------




// UITableView Delegate

//----------------------------------------------------------------------




// Drag Delegate

//----------------------------------------------------------------------




// Drop Delegate
//----------------------------------------------------------------------


