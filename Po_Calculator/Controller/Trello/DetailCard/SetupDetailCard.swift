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
    func setupSaveBtn(){
        
        guard let saveBtn = saveBtn else {
            return
        }
        
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.2).isActive = true
        saveBtn.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.04).isActive = true
        saveBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.bounds.width * 0.05).isActive = true
        saveBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.05).isActive = true
        
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(.link, for: .normal)
        saveBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: view.bounds.height * 0.03)
        saveBtn.addTarget(self, action: #selector(self.saveAction), for: .touchUpInside)
        
    }
    
    func setupCancelBtn(){
        
        guard let cancelBtn = cancelBtn else {
            return
        }
        
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.2).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.04).isActive = true
        cancelBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width * 0.05).isActive = true
        cancelBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.05).isActive = true
        
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(UIColor(named: "basicTextColor"), for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: view.bounds.height * 0.03)
        cancelBtn.addTarget(self, action: #selector(self.cancelAction), for: .touchUpInside)
    }
    
    func setUpBoard(){
        guard let lblBoard = lblBoard, let lblBoardValue = lblBoardValue, let boardStackView = boardStackView else {
            return
        }
        
        boardStackView.axis = .horizontal
        boardStackView.spacing = 10
        boardStackView.distribution = .fill
        boardStackView.alignment = .fill
        
        lblBoard.translatesAutoresizingMaskIntoConstraints = false
        lblBoardValue.translatesAutoresizingMaskIntoConstraints = false
        boardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        boardStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
        boardStackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.04).isActive = true
        boardStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.15).isActive = true
        boardStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblBoard.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9 * 0.2).isActive = true
        
        guard let board = board else {
            return
        }
        
        lblBoard.text = "Board: "
        lblBoard.font = UIFont.systemFont(ofSize: view.bounds.height * 0.02)
        lblBoardValue.text = board.title
        lblBoardValue.font = UIFont.systemFont(ofSize: view.bounds.height * 0.025)
        lblBoardValue.layer.borderWidth = 1.0
        lblBoardValue.layer.borderColor = UIColor(named: "tbCellColor")?.cgColor // UIColor(named: "basicTextColor")?.cgColor
        lblBoardValue.layer.cornerRadius = view.bounds.width * 0.01
        lblBoardValue.clearButtonMode = .whileEditing
    }
    
    func setUpList(){
        guard let boardStackView = boardStackView else {
            return
        }
        
        guard let lblList = lblList, let lblListValue = lblListValue, let listStackView = listStackView else {
            return
        }
        
        listStackView.axis = .horizontal
        listStackView.spacing = 10
        listStackView.distribution = .fill
        listStackView.alignment = .fill
        
        lblList.translatesAutoresizingMaskIntoConstraints = false
        lblListValue.translatesAutoresizingMaskIntoConstraints = false
        listStackView.translatesAutoresizingMaskIntoConstraints = false
        
        listStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
        listStackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.04).isActive = true
        listStackView.topAnchor.constraint(equalTo: boardStackView.bottomAnchor, constant: view.bounds.height * 0.01).isActive = true
        listStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblList.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9 * 0.2).isActive = true
        
        guard let list = list else {
            return
        }
        
        lblList.text = "List: "
        lblList.font = UIFont.systemFont(ofSize: view.bounds.height * 0.02)
        lblListValue.text = list.name
        lblListValue.font = UIFont.systemFont(ofSize: view.bounds.height * 0.025)
        lblListValue.layer.borderWidth = 1.0
        lblListValue.layer.borderColor = UIColor(named: "tbCellColor")?.cgColor // UIColor(named: "basicTextColor")?.cgColor
        lblListValue.layer.cornerRadius = view.bounds.width * 0.01
        lblListValue.clearButtonMode = .whileEditing
    }
    
    
    func setUpCard(){
        guard let listStackView = listStackView else {
            return
        }
        guard let lblCard = lblCard, let lblCardValue = lblCardValue, let cardStackView = cardStackView else {
            return
        }
        
        cardStackView.axis = .horizontal
        cardStackView.spacing = 10
        cardStackView.distribution = .fill
        cardStackView.alignment = .fill
        
        lblCard.translatesAutoresizingMaskIntoConstraints = false
        lblCardValue.translatesAutoresizingMaskIntoConstraints = false
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        cardStackView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
        cardStackView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.04).isActive = true
        cardStackView.topAnchor.constraint(equalTo: listStackView.bottomAnchor, constant: view.bounds.height * 0.01).isActive = true
        cardStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblCard.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9 * 0.2).isActive = true
        
        guard let card = card else {
            return
        }
        
        lblCard.text = "Card: "
        lblCard.font = UIFont.systemFont(ofSize: view.bounds.height * 0.02)
        lblCardValue.text = card.titleCard
        lblCardValue.font = UIFont.systemFont(ofSize: view.bounds.height * 0.025)
        lblCardValue.layer.borderWidth = 1.0
        lblCardValue.layer.borderColor = UIColor(named: "tbCellColor")?.cgColor // UIColor(named: "basicTextColor")?.cgColor
        lblCardValue.layer.cornerRadius = view.bounds.width * 0.01
        lblCardValue.clearButtonMode = .whileEditing
    }
    
    func setUpImagesCollectionView() {
        
        guard let imagesCollectionView = imagesCollectionView, let cardStackView = cardStackView else {
            return
        }
        
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imagesCollectionView.topAnchor.constraint(equalTo: cardStackView.bottomAnchor, constant: view.bounds.height * 0.1).isActive = true
        imagesCollectionView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.25).isActive = true
        
        imagesCollectionView.backgroundColor = UIColor(named: "backgroundBasicColor")
    }
    
    func setUpColorsCollectionView() {
        
        guard let colorsCollectionView = colorsCollectionView, let imagesCollectionView = imagesCollectionView else {
            return
        }
        
        colorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        colorsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        colorsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        colorsCollectionView.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor, constant: view.bounds.height * 0.05).isActive = true
        colorsCollectionView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.25).isActive = true
        
        colorsCollectionView.backgroundColor = UIColor(named: "backgroundBasicColor")
    }

}
