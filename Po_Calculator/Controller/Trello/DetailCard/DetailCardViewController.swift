//
//  DetailCardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/25/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class DetailCardViewController: UIViewController {
    var saveBtn: UIButton?
    var cancelBtn: UIButton?

    var lblBoard: UILabel?
    var lblBoardValue: UITextField?
    var boardStackView: UIStackView?
    
    var lblList: UILabel?
    var lblListValue: UITextField?
    var listStackView: UIStackView?
    
    var lblCard: UILabel?
    var lblCardValue: UITextField?
    var cardStackView: UIStackView?
    
    var imagesCollectionView: UICollectionView?
    var colorsCollectionView: UICollectionView?
    
    var images: [String] = Image.names
    var colors: [Color] = ListColor.colors
    
    var board: Board?
    var list: List?
    var card: Card?
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "basicBackgroundColor")
        
        saveBtn = UIButton()
        cancelBtn = UIButton()
        
        lblBoard = UILabel()
        lblBoardValue = UITextField()
        boardStackView = UIStackView()
        
        lblList = UILabel()
        lblListValue = UITextField()
        listStackView = UIStackView()
        
        lblCard = UILabel()
        lblCardValue = UITextField()
        cardStackView = UIStackView()
        
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
        guard let lblList = lblList, let lblListValue = lblListValue, let listStackView = listStackView else {
            return
        }
        guard let lblCard = lblCard, let lblCardValue = lblCardValue, let cardStackView = cardStackView else {
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
        listStackView.addArrangedSubview(lblList)
        listStackView.addArrangedSubview(lblListValue)
        view.addSubview(listStackView)
        cardStackView.addArrangedSubview(lblCard)
        cardStackView.addArrangedSubview(lblCardValue)
        view.addSubview(cardStackView)
        
        view.addSubview(imagesCollectionView)
        view.addSubview(colorsCollectionView)
        
        setupSaveBtn()
        setupCancelBtn()
        setUpBoard()
        setUpList()
        setUpCard()
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
        do {
            board?.title = lblBoardValue?.text
            list?.name = lblListValue?.text
            card?.titleCard = lblCardValue?.text
            
            try (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext.save()
            
            DispatchQueue.main.async {
                self.closeVC()
            }
        } catch {
            print(error)
        }
    }
    
    @objc func cancelAction() {
        self.closeVC()
    }

    
    func closeVC() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}


extension DetailCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            cell.layer.borderWidth = imageName == board?.thumbnail ? cell.bounds.width * 0.05 : 0.0
            
            return cell
        }

        // Color
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BackgroundColorBoardCell", for: indexPath) as! BackgroundColoBoardCLVCell
        let color = colors[indexPath.row]
        cell.layer.cornerRadius = cell.bounds.width * 0.05
        cell.backgroundColor = color.toUIColor()
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = color.toString() == board?.thumbnail ? cell.bounds.width * 0.05 : 0.0
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            board?.thumbnail = images[indexPath.row]
            self.colorsCollectionView?.reloadData()
        }
        else if collectionView.tag == 1 {
            board?.thumbnail = colors[indexPath.row].toString()
            self.imagesCollectionView?.reloadData()
        }
        
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
    }
    
}
