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
    
    // Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var listBoard: [Board] = []
    
    // Properties
    var currentSelectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        fetchBoard()
    }
}

extension ListBoardViewController: UITableViewDelegate, UITableViewDataSource {
    // Section:
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Row:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBoard.count
    }
    
    // Cell:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as! BoardTableViewCell
        let board = listBoard[indexPath.row]
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
                destination.navigationItem.title = listBoard[indexPath.row].title
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
            let row = (indexPath as NSIndexPath).row
            let boardToRemove = listBoard[row]
            context.delete(boardToRemove)
            
            do {
                try context.save()
            } catch {
                print(error)
            }
            
            fetchBoard()
            
//            let indexPaths = [indexPath]
//            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
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
    func fetchBoard() {
        do {
            listBoard = try context.fetch(Board.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Cannot fetch board because:")
            print(error)
        }
    }
    
    func fetchBoard(by predicateString: String) {
        do {
            let request: NSFetchRequest = Board.fetchRequest()
            let predicate: NSPredicate = NSPredicate(format: predicateString)
            
            request.predicate = predicate
            listBoard = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Cannot fetch board because:")
            print(error)
        }
    }
    
}

