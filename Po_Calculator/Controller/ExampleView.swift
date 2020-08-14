//
//  ExampleView.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/13/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class ExampleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var tableView: UITableView!
    
    var listExamples: [Example] = []

    func GetInformation(from path: String) {
        
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else { fatalError() }
        
        do {
            let rawData = try Data(contentsOf: url)
            
            let data = try JSONDecoder().decode([Example].self, from: rawData)
            
            for example in data {
                listExamples<-example
            }
            print(listExamples)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        
        let _ = loadViewFromNib()
        GetInformation(from: "example")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ExampleCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleCell")
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        
        let nib = UINib(nibName: "ExampleView", bundle: bundle)
        
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [ UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight ]
        
        addSubview(view)
        return view
    }
}

extension ExampleView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listExamples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell") as! ExampleCellTableViewCell
        
        let example = listExamples[indexPath.row]
        
        cell.lblNameValue.text = example.name
        cell.lblDobValue.text = example.dob
        cell.lblCompanyValue.text = example.company
        cell.lblAddressValue.text = example.address
        cell.lblFoundedValue.text = example.founded
        
        // Validate founders array, and convert to string
        var founders:String = ""
        if let numberOfFounders = example.co_founders?.count {
            if numberOfFounders > 0 {
                for i in 0..<numberOfFounders - 1  {
                    if let founder = example.co_founders?[i] {
                        founders += founder + ", "
                    }
                }
                if let founder = example.co_founders?[numberOfFounders-1] {
                    founders += founder
                }
            }
        }
        
        
        cell.lblFoundersValue.text = founders
        
        return cell
    }
    
}
