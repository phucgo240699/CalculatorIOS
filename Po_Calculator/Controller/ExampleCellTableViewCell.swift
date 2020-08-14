//
//  ExampleCellTableViewCell.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/13/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class ExampleCellTableViewCell: UITableViewCell {

    
    @IBOutlet var lblNameValue: UILabel!
    @IBOutlet var lblDobValue: UILabel!
    @IBOutlet var lblCompanyValue: UILabel!
    @IBOutlet var lblAddressValue: UILabel!
    @IBOutlet var lblFoundedValue: UILabel!
    @IBOutlet var lblFoundersValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
