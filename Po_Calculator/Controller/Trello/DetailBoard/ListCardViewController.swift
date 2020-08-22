//
//  ListCardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/19/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class ListCardViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var addCardBtn: UIButton!
    @IBOutlet var addBtn: UIButton!
    
    @IBOutlet var heightTableView: NSLayoutConstraint!
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        cancelBtn.isHidden = true
        addBtn.isHidden = true
        addCardBtn.isHidden = false
        listCard.remove(at: listCard.count-1)
        updateTableView(&heightTableView, &tableView)
    }
    
    @IBAction func addCardBtnPressed(_ sender: UIButton) {
        cancelBtn.isHidden = false
        addBtn.isHidden = false
        addCardBtn.isHidden = true
        listCard.append("")
        updateTableView(&heightTableView, &tableView)
    }
    @IBAction func addBtnPressed(_ sender: UIButton) {
        let text: String = (tableView.cellForRow(at: IndexPath(row: listCard.count - 1, section: 0)) as! CardTableViewCell).title.text ?? ""
        
        for char in text {
            if char != " " {
                listCard.remove(at: listCard.count - 1)
                listCard.append(text)
                listCard.append("")
                updateTableView(&heightTableView, &tableView)
                return
            }
        }
        
        cancelBtn.isHidden = true
        addBtn.isHidden = true
        addCardBtn.isHidden = false
        listCard.remove(at: listCard.count-1)
        updateTableView(&heightTableView, &tableView)
    }
    
    var listCard: [String] = ["One", "Two", "Third", "Fourth", "Fifth"]
    var rowHeight: CGFloat = 44.0
    var currentIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardCell")
        tableView.separatorStyle = .none
        rowHeight = view.frame.width * 0.15
        tableView.rowHeight = rowHeight
        tableView.layer.cornerRadius = tableView.bounds.width * 0.02
        
        heightTableView.constant = CGFloat(listCard.count) * rowHeight + tableView.sectionHeaderHeight

        
        cancelBtn.isHidden = true
        addBtn.isHidden = true
        addCardBtn.isHidden = false
    }

}


extension ListCardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ABC"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: tableView.bounds.width - tableView.sectionHeaderHeight, y: 0.0, width: tableView.sectionHeaderHeight, height: tableView.sectionHeaderHeight))
        
        
        let button = UIButton(type: .system)
        view.addSubview(button)
        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        button.setTitle("Open", for: .normal)
        
        
        button.addTarget(self, action: #selector(buttonclick), for: .touchUpInside)

        return view
    }
    @objc func buttonclick () {
        print("Asdfdasf")
    }
    
    func updateTableView(_ heightTableView: inout NSLayoutConstraint, _ tableView: inout UITableView) {
        heightTableView.constant = CGFloat(listCard.count) * rowHeight + tableView.sectionHeaderHeight
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCard.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardTableViewCell
        cell.container.layer.cornerRadius = 10
        cell.selectionStyle = .none
        
        cell.title.text = listCard[indexPath.row]
        cell.title.isUserInteractionEnabled = true
        for e in listCard[indexPath.row] {
            if e != " " {
                cell.title.isUserInteractionEnabled = false
                break
            }
        }
        
        return cell
    }
    
    

}
