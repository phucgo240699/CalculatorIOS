//
//  BoardTableViewCell.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/19/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UIDevice.current.userInterfaceIdiom == .pad {
            title.font = UIFont.boldSystemFont(ofSize: bounds.height * 0.8)
        }
        else if UIDevice.current.userInterfaceIdiom == .phone {
            title.font = UIFont.boldSystemFont(ofSize: bounds.height * 0.5)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
