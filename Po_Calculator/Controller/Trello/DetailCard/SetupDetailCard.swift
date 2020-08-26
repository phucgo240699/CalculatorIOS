//
//  SetupDetailCard.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/26/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

extension DetailCardViewController {
    func setUpBoard(){
        lblBoard = UILabel()
        lblBoardValue = UILabel()
        boardStackView = UIStackView()
        
        guard let lblBoard = lblBoard, let lblBoardValue = lblBoardValue, let boardStackView = boardStackView else {
            return
        }
        
        self.view.addSubview(boardStackView)
        boardStackView.addArrangedSubview(lblBoard)
        boardStackView.addArrangedSubview(lblBoardValue)
        boardStackView.axis = .horizontal
        
        lblBoard.translatesAutoresizingMaskIntoConstraints = false
        lblBoardValue.translatesAutoresizingMaskIntoConstraints = false
        boardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        lblBoard.widthAnchor.constraint(equalToConstant: boardStackView.bounds.width * 0.1).isActive = true
        boardStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
        boardStackView.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.1).isActive = true
        boardStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
    }
}
