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
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


