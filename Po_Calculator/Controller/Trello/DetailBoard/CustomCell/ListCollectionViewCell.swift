//
//  ListCollectionViewCell.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/26/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    var tableView: UITableView!
//    var tmpIndex : Int?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        tableView = UITableView()
        self.addSubview(tableView)
        tableView.rowHeight = self.bounds.width * 0.2
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        tableView.layer.cornerRadius = self.bounds.width * 0.02
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


