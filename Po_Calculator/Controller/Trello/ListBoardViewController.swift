//
//  ListBoardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/18/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class ListBoardViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var listBoard: [Board] = [Board(thumbnail: "heart", title: "Heart"),Board(thumbnail: "calendar", title: "Calendar"),Board(thumbnail: "trash", title: "Trash"),Board(thumbnail: "tray", title: "Tray"),Board(thumbnail: "doc", title: "Doc")]
    var currentSelectedIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BoardTableViewCell", bundle: nil), forCellReuseIdentifier: "BoardCell")
        tableView.rowHeight = self.view.frame.height * 0.07
        
        searchBar.delegate = self
        hideKeyboardWhenTappedAround()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.cellForRow(at: currentSelectedIndex)?.selectionStyle = .none
    }
}

extension ListBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBoard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BoardCell", for: indexPath) as! BoardTableViewCell
        
        let board = listBoard[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.setUpContainer()
        cell.thumbnail.image = UIImage(systemName: board.thumbnail)
        cell.title.text = board.title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if type(of: destination) == DetailBoardViewController.self {
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.navigationItem.title = listBoard[indexPath.row].title
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .gray
        currentSelectedIndex = indexPath
        performSegue(withIdentifier: "gotoDetailBoard", sender: self)
    }
    //
    // Swipe
    //
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let row = (indexPath as NSIndexPath).row
            listBoard.remove(at: row)
            
            let indexPaths = [indexPath]
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
    }
    
    
}


extension ListBoardViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
