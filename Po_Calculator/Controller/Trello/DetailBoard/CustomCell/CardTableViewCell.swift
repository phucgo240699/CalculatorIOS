//
//  CardTableViewCell.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/26/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    var cardNameLbl: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cardNameLbl = UILabel()
        self.contentView.addSubview(cardNameLbl)
        
        cardNameLbl.translatesAutoresizingMaskIntoConstraints = false
        cardNameLbl.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardNameLbl.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardNameLbl.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardNameLbl.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            cardNameLbl.font = UIFont(name: cardNameLbl.font.fontName , size: self.bounds.height * 0.6 )

            cardNameLbl.layer.cornerRadius = 30
            cardNameLbl.layer.shadowRadius = 6
        }
        else if UIDevice.current.userInterfaceIdiom == .phone {
            cardNameLbl.font = UIFont(name: "Helvetica Neue" , size: self.bounds.height * 0.5 )

            cardNameLbl.layer.cornerRadius = 30
            cardNameLbl.layer.shadowRadius = 6
        }
        
        cardNameLbl.backgroundColor = UIColor(named: "tbCellColor")
        cardNameLbl.textAlignment = .center
        cardNameLbl.layer.shadowColor = UIColor(named: "basicTextColor")?.cgColor
        cardNameLbl.layer.shadowOpacity = 0.5
        cardNameLbl.layer.shadowOffset = .zero
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    
    
}
