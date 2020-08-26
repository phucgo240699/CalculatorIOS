//
//  listCardTitleViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/19/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import CoreData

class ListCardViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var addCardBtn: UIButton!
    @IBOutlet var addBtn: UIButton!
    let refreshControl = UIRefreshControl()
    @IBOutlet var heightTableView: NSLayoutConstraint!
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        cancelBtn.isHidden = true
        addBtn.isHidden = true
        addCardBtn.isHidden = false
        
        let n = cards.count
        if (n <= 0 ) {
            return
        }
        
        if (cards[n-1].titleCard == nil || cards[n-1].titleCard?.isEmptyOrSpaceing() == true) {
            cards.remove(at: n-1)
            
            updateTableView(&heightTableView, &tableView)
        }
    }
    
    @IBAction func addCardBtnPressed(_ sender: UIButton) {
        cancelBtn.isHidden = false
        addBtn.isHidden = false
        addCardBtn.isHidden = true
        
        let card = Card(context: context)
        card.isDone = false
        card.list = list
        card.id = Int64(cards.count)
        cards.append(card)
        
        updateTableView(&heightTableView, &tableView)
    }
    @IBAction func addBtnPressed(_ sender: UIButton) {
        // Get text of textfield
        let text: String = (tableView.cellForRow(at: IndexPath(row: cards.count - 1, section: 0)) as! CardTableViewCell).title.text ?? ""

        // Check text is empty
        for char in text {
            if char != " " {
                cards[cards.count - 1].titleCard = text
                
                
                do {
                    try context.save()
                } catch {
                    print(error)
                }
                
                cancelBtn.isHidden = true
                addBtn.isHidden = true
                addCardBtn.isHidden = false
                
                updateTableView(&heightTableView, &tableView)
                return
            }
        }

        cancelBtn.isHidden = true
        addBtn.isHidden = true
        addCardBtn.isHidden = false
        
        cards.remove(at: cards.count-1)
        
        fetchCardsAndReload()
    }
    
    // Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var list: List? {
        didSet {
            if let list = list {
                if cards.count <= 0 {
                    cards = CustomCard.shared.getCardsSorting(list: list, by: "id", ascending: ascendingId)
                }
            }
        }
    }
    var cards: [Card] = []
    var ascendingId: Bool = true
    
    // Properties
    var rowHeight: CGFloat = 44.0
    var currentIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        tableView.separatorStyle = .none
        rowHeight = view.frame.width * 0.15
        tableView.rowHeight = rowHeight
        tableView.layer.cornerRadius = tableView.bounds.width * 0.02
        
        heightTableView.constant = CGFloat(cards.count) * rowHeight  +  tableView.sectionHeaderHeight + 10

        
        cancelBtn.isHidden = true
        addBtn.isHidden = true
        addCardBtn.isHidden = false
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let n = cards.count
        if n <= 0 {
            return
        }
        if (cards[n-1].titleCard == nil || cards[n-1].titleCard?.isEmptyOrSpaceing() == true) {
            
            
            do {
                context.delete(cards[n-1])
                try context.save()
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}


extension ListCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  list != nil ? list?.name : nil
    }
    
    func updateTableView(_ heightTableView: inout NSLayoutConstraint, _ tableView: inout UITableView) {
        
        heightTableView.constant = CGFloat(cards.count) * rowHeight +  tableView.sectionHeaderHeight + 10
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardTableViewCell
        cell.layer.cornerRadius = cell.bounds.height * 0.5
        cell.container.layer.cornerRadius = cell.bounds.height * 0.5
        cell.selectionStyle = .none
        cell.title.isUserInteractionEnabled = true
        cell.title.text = cards[indexPath.row].titleCard
        cell.accessoryType = cards[indexPath.row].isDone == true ? .checkmark : .none
        
        if let titleCard = cards[indexPath.row].titleCard{
            for e in titleCard {
                if e != " " {
                    cell.title.isUserInteractionEnabled = false
                    break
                }
            }
        }
        return cell
    }
    
    // Delete Cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let row = (indexPath as NSIndexPath).row
            
            CustomCard.shared.deleteCard(index: row)
            
            fetchCardsAndReload()
        }
    }
    
    // Re-ordering
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let from = sourceIndexPath.row
        let to = destinationIndexPath.row
        
        CustomCard.shared.swapCardID(fromIndex: from, toIndex: to)
    }
    
    // Selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        (tableView.cellForRow(at: indexPath) as! CardTableViewCell).title.isUserInteractionEnabled = true
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailCard") as? DetailCardViewController {
            detailVC.modalPresentationStyle = .popover
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}


// Function Support
extension ListCardViewController {
    
    @objc func refresh(_ sender: AnyObject) {
        fetchCardsAndReload()
        refreshControl.endRefreshing()
    }
    
    func fetchCardsAndReload() {
        if let list = list {
            cards = CustomCard.shared.getCardsSorting(list: list, by: "id", ascending: ascendingId)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
