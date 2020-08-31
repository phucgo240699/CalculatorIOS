//
//  CreationCardBoardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/18/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit
import CoreData

class CreationBoardViewController: UIViewController {
    
    @IBOutlet var titleBoard: UITextField!
    @IBOutlet var backgroundImageCLV: UICollectionView!
    @IBOutlet var backgroundColorCLV: UICollectionView!
    
    @IBOutlet var addButton: UIButton!
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        self.closeVC()
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        if let title = titleBoard.text, let thumbnail = newThumbnail {
            var newIndex : Int?
            newIndex = CustomBoard.shared.getBoardsSorting(by: "id", ascending: true).count
            CustomBoard.shared.addBoard(thumbnail: thumbnail, title: title)
            
            self.closeVC()
        }
    }
    
    // Coredata
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var newThumbnail: String?
    
    // Properties
    var listImageBackground: [String] = Image.names
    var listColorBackground : [Color] = ListColor.colors
    
    var selectedBackgroundIndex: IndexPath?
    var selectedColorIndex: IndexPath?
    var isFirstLookAtBackgroundCollectionView: Bool = true
    var isFirstLookAtColorCollectionView: Bool = true
    var borderWidthCell : CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleBoard.delegate = self
        
        backgroundImageCLV.delegate = self
        backgroundImageCLV.dataSource = self
        backgroundImageCLV.register(UINib(nibName: "BackgroundImageBoardCLVCell", bundle: nil), forCellWithReuseIdentifier: "BackgroundImageBoardCell")
        
        
        backgroundColorCLV.delegate = self
        backgroundColorCLV.dataSource = self
        backgroundColorCLV.register(UINib(nibName: "BackgroundColoBoardCLVCell", bundle: nil), forCellWithReuseIdentifier: "BackgroundColorBoardCell")
        
        
        hideKeyboardWhenTappedAround()
        
    }
}

// Function Support
extension CreationBoardViewController {
    func closeVC() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

// Collection View
extension CreationBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeSize = collectionView.bounds.width / 4 - 5
        return CGSize(width: edgeSize, height: edgeSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? listImageBackground.count : listColorBackground.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        
        // Color
        if collectionView.tag == 1 {
            let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundColorBoardCell", for: indexPath) as! BackgroundColoBoardCLVCell

            colorCell.contentView.layer.cornerRadius = colorCell.bounds.width * 0.08
            colorCell.contentView.backgroundColor = listColorBackground[indexPath.row].toUIColor()
            colorCell.layer.borderColor = UIColor.black.cgColor
            
            if (selectedBackgroundIndex != nil){
                colorCell.layer.borderWidth = 0.0
            }
            else {
                if indexPath == selectedColorIndex{
                    colorCell.layer.borderWidth = borderWidthCell
                }
                else {
                    colorCell.layer .borderWidth = 0.0
                }
            }
            
            return colorCell
        }
        //------------------------------
        
        // Background image
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundImageBoardCell", for: indexPath) as! BackgroundImageBoardCLVCell)
        cell.contentView.layer.cornerRadius = cell.bounds.width * 0.08
        cell.backgroundImg.image = UIImage(named: listImageBackground[row])
        cell.layer.borderColor = UIColor.lightGray.cgColor
            
        if isFirstLookAtBackgroundCollectionView { //Default highlighted
            if row == 0 {
                cell.layer.borderWidth = borderWidthCell
                newThumbnail = listImageBackground[row]
                isFirstLookAtBackgroundCollectionView = false
            }
        }
        else {
            if (selectedColorIndex != nil){
                cell.layer.borderWidth = 0.0
            }
            else {
                if indexPath == selectedBackgroundIndex{
                    cell.layer.borderWidth = borderWidthCell
                }
                else {
                    cell.layer .borderWidth = 0.0
                }
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            selectedBackgroundIndex = indexPath
            newThumbnail = listImageBackground[indexPath.row]
            selectedColorIndex = nil
            backgroundColorCLV.reloadData()
        }
        else {
            selectedColorIndex = indexPath
            newThumbnail = listColorBackground[indexPath.row].toString()
            selectedBackgroundIndex = nil
            backgroundImageCLV.reloadData()
        }
        
        collectionView.reloadData()
    }
}

// Text Field
extension CreationBoardViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if titleBoard.text?.count ?? 0 > 0 {
            addButton.isEnabled = true
        }
        else {
            addButton.isEnabled = false
        }
    }
}
