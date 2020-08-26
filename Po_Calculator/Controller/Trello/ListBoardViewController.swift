//
//  ListBoardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/18/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import CoreData

class ListBoardViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var editBtn: UIBarButtonItem!
    var refreshControl = UIRefreshControl()
    
    // Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var boards: [Board] = []
    
    // Properties
    var currentSelectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BoardTableViewCell", bundle: nil), forCellReuseIdentifier: "BoardCell")
        tableView.rowHeight = self.view.frame.height * 0.07
        tableView.cellForRow(at: currentSelectedIndex)?.selectionStyle = .none
        
        searchBar.delegate = self
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FethAndReload()
    }
}

extension ListBoardViewController: UITableViewDelegate, UITableViewDataSource {
    // Section:
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Row:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }
    
    // Cell:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as! BoardTableViewCell
        let board = boards[indexPath.row]
        guard let thumbnail = board.thumbnail else { return cell }
        
        cell.accessoryType = .disclosureIndicator
        
        if thumbnail.toColor() == .black {
            cell.thumbnail.backgroundColor = UIColor.clear
            cell.thumbnail.image = UIImage(systemName: thumbnail)
        }
        else {
            cell.thumbnail.image = nil
            cell.thumbnail.backgroundColor = thumbnail.toColor().toUIColor()
        }
        cell.thumbnail.layer.cornerRadius = cell.bounds.width * 0.01
        cell.title.text = board.title
        
        return cell
    }
    
    // Prepare move to another View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        if type(of: destination) == DetailBoardViewController.self {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                (destination as! DetailBoardViewController).navigationItem.title = boards[indexPath.row].title
                (destination as! DetailBoardViewController).board = boards[indexPath.row]
            }
            
        }
    }
    
    // Did Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .gray
        currentSelectedIndex = indexPath
        performSegue(withIdentifier: "gotoDetailBoard", sender: self)
    }
    
    // Swipe
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            CustomBoard.shared.deleteBoard(index: indexPath.row)
            
            FethAndReload()
        }
    }
    
    // Re-ordering
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
            editBtn.title = "Edit"
        }
        else {
            tableView.isEditing = true
            editBtn.title = "Done"
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let from = sourceIndexPath.row
        let to = destinationIndexPath.row
        
        CustomBoard.shared.swapBoardID(fromIndex: from, toIndex: to)
    }
}

// Search Bar
extension ListBoardViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

// Functions support
extension ListBoardViewController {
    
    @objc func refresh(_ sender: AnyObject) {
        boards = CustomBoard.shared.getBoardsSorting(by: "id", ascending: true)
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func FethAndReload() {
        boards = CustomBoard.shared.getBoardsSorting(by: "id", ascending: true)
        
        tableView.reloadData()
    }
}

