//
//  DetailCardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/25/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class DetailCardViewController: UIViewController {

    var lblBoard: UILabel?
    var lblBoardValue: UILabel?
    var boardStackView: UIStackView?
    
    var lblList: UILabel?
    var lblListValue: UILabel?
    var listStackView: UIStackView?
    
    var lblCard: UILabel?
    var lblCardValue: UILabel?
    var cardStackView: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail Card"
        view.backgroundColor = .yellow
        setUpBoard()
        
    }
    
    


}
