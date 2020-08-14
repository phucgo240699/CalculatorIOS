//
//  ExampleViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/14/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
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
            print(listExamples.count)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ExampleCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleCell")
        GetInformation(from: "example")
    }

}


extension ExampleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listExamples.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell", for: indexPath) as! ExampleCellTableViewCell
        
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
                if let founder = example.co_founders?[numberOfFounders-1]{
                        founders += founder
                }
            }
        }


        cell.lblFoundersValue.text = founders
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Bundle identifier
        if indexPath.row % 2 == 0 {
            if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailExample") as? DetailExampleViewController {
                detailVC.modalPresentationStyle = .popover
                present(detailVC, animated: true, completion: nil)
            }
               
        }

        // Segue
        else {
            performSegue(withIdentifier: "moveToDetailExample", sender: self)
        }
    }
}
