//
//  CreationCardBoardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/18/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import CoreData

class CreationBoardViewControlelr: UIViewController {
    var saveBtn: UIButton?
    var cancelBtn: UIButton?

    var lblBoard: UILabel?
    var lblBoardValue: UITextField?
    var boardStackView: UIStackView?
    
    var imagesCollectionView: UICollectionView? // tag = 0
    var colorsCollectionView: UICollectionView? // tag = 1
    
    var images: [String] = Image.names
    var colors: [Color] = ListColor.colors
    
    var selectedCellIndex: Int = 0
    var selectedCollectionViewIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "basicBackgroundColor")
        
        saveBtn = UIButton()
        cancelBtn = UIButton()
        
        lblBoard = UILabel()
        lblBoardValue = UITextField()
        boardStackView = UIStackView()
        
        let layoutImage = UICollectionViewFlowLayout()
        layoutImage.scrollDirection = .horizontal
        imagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutImage)
        imagesCollectionView?.tag = 0
        
        let layoutColor = UICollectionViewFlowLayout()
        layoutColor.scrollDirection = .horizontal
        colorsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutColor)
        colorsCollectionView?.tag = 1
        
        
        guard let saveBtn = saveBtn else {
            return
        }
        guard let cancelBtn = cancelBtn else {
            return
        }
        guard let lblBoard = lblBoard, let lblBoardValue = lblBoardValue, let boardStackView = boardStackView else {
            return
        }
        
        guard let imagesCollectionView = imagesCollectionView else {
            return
        }
        guard let colorsCollectionView = colorsCollectionView else {
            return
        }
        
        view.addSubview(saveBtn)
        view.addSubview(cancelBtn)
        
        boardStackView.addArrangedSubview(lblBoard)
        boardStackView.addArrangedSubview(lblBoardValue)
        view.addSubview(boardStackView)
        view.addSubview(imagesCollectionView)
        view.addSubview(colorsCollectionView)
        
        setupSaveBtn()
        setupCancelBtn()
        setUpBoard()
        setUpImagesCollectionView()
        setUpColorsCollectionView()
        
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(UINib(nibName: "BackgroundImageBoardCLVCell", bundle: nil), forCellWithReuseIdentifier: "BackgroundImageBoardCell")
        
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        colorsCollectionView.register(UINib(nibName: "BackgroundColoBoardCLVCell", bundle: nil), forCellWithReuseIdentifier: "BackgroundColorBoardCell")
    }
    
    @objc func saveAction() {

        guard lblBoardValue != nil && lblBoardValue?.text != nil &&  lblBoardValue?.text?.isEmptyOrSpaceing() == false else {
            return
        }
        var thumbnail = ""
        if selectedCollectionViewIndex == 0 {
            thumbnail = images[selectedCellIndex]
        }
        else if selectedCollectionViewIndex == 1 {
            thumbnail = colors[selectedCellIndex].toString()
        }
        
        CustomBoard.shared.addBoard(thumbnail: thumbnail, title: (lblBoardValue?.text!)!)
        
        self.closeVC()
    }
    
    @objc func cancelAction() {
        self.closeVC()
    }

    
    func closeVC() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension CreationBoardViewControlelr: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.height * 0.2, height: view.bounds.height * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? images.count : colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            // Image
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundImageBoardCell", for: indexPath) as! BackgroundImageBoardCLVCell
            let imageName = images[indexPath.row]
            cell.backgroundImg.contentMode = .scaleAspectFill
            cell.layer.cornerRadius = cell.bounds.width * 0.05
            cell.backgroundImg.image = UIImage(named: imageName)
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = (selectedCollectionViewIndex == collectionView.tag && selectedCellIndex == indexPath.row) ? cell.bounds.width * 0.05 : 0.0
            
            return cell
        }

        // Color
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundColorBoardCell", for: indexPath) as! BackgroundColoBoardCLVCell
        let color = colors[indexPath.row]
        cell.layer.cornerRadius = cell.bounds.width * 0.05
        cell.backgroundColor = color.toUIColor()
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = (selectedCollectionViewIndex == collectionView.tag && selectedCellIndex == indexPath.row) ? cell.bounds.width * 0.05 : 0.0
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedCollectionViewIndex == collectionView.tag {
            selectedCollectionViewIndex = collectionView.tag
            selectedCellIndex = indexPath.row
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        else {
            selectedCollectionViewIndex = collectionView.tag
            selectedCellIndex = indexPath.row
            DispatchQueue.main.async {
                self.imagesCollectionView?.reloadData()
                self.colorsCollectionView?.reloadData()
            }
        }
        
    }
    
}
