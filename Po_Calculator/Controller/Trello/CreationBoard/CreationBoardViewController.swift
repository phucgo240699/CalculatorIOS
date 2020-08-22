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
    @IBOutlet var backgroundBoardCLV: UICollectionView!         // tag 0
    @IBOutlet var backgroundColorBoardCLV: UICollectionView!    // tag 1
    @IBOutlet var addButton: UIButton!
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        self.closeVC()
    }
    
    @IBAction func addBtnPressed(_ sender: UIButton) {
        let board = Board(context: context)
        if let title = titleBoard.text, let thumbnail = newThumbnail {
            board.title = title
            board.thumbnail = thumbnail
            do {
                try context.save()
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.closeVC()
            }

        }
    }
    
    // Coredata
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    var newThumbnail: String?
    
    // Properties
    var listBoardBackground: [String] = ["heart", "calendar", "trash", "tray", "doc"]
    var listBoardColor : [Color] = [.red, .pink, .organe, .yellow, .green, .blue, .purple, .silver]
    
    var selectedBackgroundIndex: IndexPath?
    var selectedColorIndex: IndexPath?
    var isFirstLookAtBackgroundCollectionView: Bool = true
    var isFirstLookAtColorCollectionView: Bool = true
    var borderWidthCell : CGFloat = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleBoard.delegate = self

        backgroundBoardCLV.delegate  = self
        backgroundBoardCLV.dataSource = self
        backgroundBoardCLV.register(UINib(nibName: "BackgroundBoardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BackgroundBoardCell")
        
        backgroundColorBoardCLV.delegate = self
        backgroundColorBoardCLV.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    
}

// Function Support
extension CreationBoardViewController {
    func closeVC() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

// Collection View
extension CreationBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? listBoardBackground.count : listBoardColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let edgeSize = collectionView.bounds.width / 4 - 5
        
        // Color
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorBoardCell", for: indexPath)
            cell.frame.size = CGSize(width: edgeSize, height: edgeSize)
            cell.contentView.layer.cornerRadius = cell.bounds.width * 0.08
            cell.contentView.backgroundColor = listBoardColor[indexPath.row].toUIColor()
            cell.layer.borderColor = UIColor.black.cgColor
            
            if (selectedBackgroundIndex != nil){
                cell.layer.borderWidth = 0.0
            }
            else {
                if indexPath == selectedColorIndex{
                    cell.layer.borderWidth = borderWidthCell
                }
                else {
                    cell.layer .borderWidth = 0.0
                }
            }
            
            return cell
        }
        //------------------------------
        
        // Background image
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundBoardCell", for: indexPath) as! BackgroundBoardCollectionViewCell
        cell.frame.size = CGSize(width: edgeSize, height: edgeSize)
        cell.contentView.layer.cornerRadius = cell.bounds.width * 0.08
        cell.backgroundImg.image = UIImage(systemName: listBoardBackground[row])
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        if isFirstLookAtBackgroundCollectionView { //Default highlighted
            if row == 0 {
                cell.layer.borderWidth = borderWidthCell
                newThumbnail = listBoardBackground[row]
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
            newThumbnail = listBoardBackground[indexPath.row]
            selectedColorIndex = nil
            backgroundColorBoardCLV.reloadData()
        }
        else {
            selectedColorIndex = indexPath
            newThumbnail = listBoardColor[indexPath.row].toString()
            selectedBackgroundIndex = nil
            backgroundBoardCLV.reloadData()
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
