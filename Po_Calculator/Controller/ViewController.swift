//
//  ViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/11/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

@IBDesignable class RoundedButton: UIButton
{
    @IBInspectable var roundedButton: Bool = false {
        didSet {
            if roundedButton {
                layer.cornerRadius = frame.height * 0.5
            }
        }
    }

    override func prepareForInterfaceBuilder() {
        if roundedButton {
            layer.cornerRadius = frame.height * 0.5
        }
    }
}

enum Operation {
    case add
    case minus
    case multiply
    case divide
    case null
    
}

struct Number {
    var value: Double?
    var isNil: Bool
}

class ViewController: UIViewController {
    var listExamples: [Example] = []


    func GetInformation(from path: String) {
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else { fatalError() }
        
        do {
            let rawData = try Data(contentsOf: url)
            
            let data = try JSONDecoder().decode([Example].self, from: rawData)
                
            for example in data {
                print(example)
                listExamples<-example
            }
            print(listExamples)
        } catch {
            print(error)
        }
    }
    
    func calculate(_ x: Double, _ y: Double, paraOperator: Operation) -> Double {
        switch paraOperator {
        case .add:
            return x + y
        case .minus:
            return x - y
        case .multiply:
            return x * y
        
        default:
            return x / y
        }
    }
    
    @IBAction func numberPressed(_ sender: RoundedButton) {
        if ( a == nil && b == nil && c == nil ){
            if sender.tag != 0 {
                lblDisplay.text = String(sender.tag)
                a = lblDisplay.text?.toDouble()
            }
        }
        else if ( a != nil && b == nil && c == nil ){
            if firstOperator == .null {
                if (lblDisplay.text?.include("-"))! {
                    a = lblDisplay.text?.toDouble()
                    a! -= Double(sender.tag)
                    lblDisplay.text = String(a!)
                }
                else {
                    lblDisplay.text! += String(sender.tag)
                    a = lblDisplay.text?.toDouble()
                }
            }
            else if firstOperator != .null {
                if (lblDisplay.text?.include("-"))! {
                    b = lblDisplay.text?.toDouble()
                    b! -= Double(sender.tag)
                    lblDisplay.text = String(b!)
                }
                else {
                    lblDisplay.text = String(sender.tag)
                    b = lblDisplay.text?.toDouble()
                }
            }
        }
        else if ( a != nil && b != nil && c == nil ){
            if secondOperator == .null {
                if (lblDisplay.text?.include("-"))! {
                    b = lblDisplay.text?.toDouble()
                    b! -= Double(sender.tag)
                    lblDisplay.text = String(b!)
                }
                else {
                    lblDisplay.text! += String(sender.tag)
                    b = lblDisplay.text?.toDouble()
                }
                
            }
            else {
                if (lblDisplay.text?.include("-"))! {
                    c = lblDisplay.text?.toDouble()
                    c! -= Double(sender.tag)
                    lblDisplay.text = String(c!)
                }
                else {
                    lblDisplay.text = String(sender.tag)
                    c = lblDisplay.text?.toDouble()
                }
            }
        }
        else if ( a != nil && b != nil && c != nil ){
            lblDisplay.text! += String(sender.tag)
            c = lblDisplay.text?.toDouble()
        }
    }
    
    @IBAction func acBtn(_ sender: Any) {
        a = nil
        b = nil
        c = nil
        firstOperator = .null
        secondOperator = .null
        lblDisplay.text = "0"
    }
    
    @IBAction func modBtn(_ sender: Any) {
        if ( a == nil && b == nil && c == nil ) {
            
        }
        else if ( a != nil && b == nil && c == nil ) {
            a! /= 100
            lblDisplay.text = String(a!)
        }
        else if ( a != nil && b != nil && c == nil ) {
            b! /= 100
            lblDisplay.text = String(b!)
        }
        else if ( a != nil && b != nil && c != nil ) {
            c! /= 100
            lblDisplay.text = String(c!)
        }
    }
    
    @IBAction func posNavBtn(_ sender: Any) {
        if ( a == nil && b == nil && c == nil ){
            if firstOperator == .null && secondOperator == .null {
                a = 0
                lblDisplay.text = "-" + String(a!)
            }
//            else if firstOperator != .null && secondOperator == .null {
//
//            }
//            else if firstOperator != .null && secondOperator != .null {
//
//            }
        }
            
        else if ( a != nil && b == nil && c == nil ){
            if firstOperator == .null && secondOperator == .null {
                a! *= -1.0
                lblDisplay.text = String(a!)
            }
            else if firstOperator != .null && secondOperator == .null {
                b = 0
                lblDisplay.text = "-" + String(b!)
            }
//            else if firstOperator != .null && secondOperator != .null {
//                
//            }

            
        }
            
        else if ( a != nil && b != nil && c == nil ){
//            if firstOperator == .null && secondOperator == .null {
//
//            }
            if firstOperator != .null && secondOperator == .null {
                b! *= -1
                lblDisplay.text = "-" + String(b!)
            }
            else if firstOperator != .null && secondOperator != .null {
                c = 0
                lblDisplay.text = "-" +  String(c!)
            }
        }
            
        else if ( a != nil && b != nil && c != nil ){
//            if firstOperator == .null && secondOperator == .null {
//
//            }
//            else if firstOperator != .null && secondOperator == .null {
//
//            }
            if firstOperator != .null && secondOperator != .null {
                c! *= -1
                lblDisplay.text = String(c!)
            }
        }
    }
    
    // + - x /
    @IBAction func divideBtn(_ sender: Any) {
        if ( a == nil && b == nil && c == nil ){
            a = 0.0
            firstOperator = .divide
        }
            
        else if ( a != nil && b == nil && c == nil ){
            firstOperator = .divide
        }
            
        else if ( a != nil && b != nil && c == nil ){
            if firstOperator == .add || firstOperator == .minus {
                secondOperator = .divide
            }
            else {
                a = calculate(a!, b!, paraOperator: firstOperator)
                b = nil
                firstOperator = .divide
                lblDisplay.text = String(a!)
            }
        }
            
        else if ( a != nil && b != nil && c != nil ){
            b = calculate(b!, c!, paraOperator: secondOperator)
            c = nil
            secondOperator = .divide
            lblDisplay.text = String(b!)
        }
        
    }
    
    @IBAction func multiplyBtn(_ sender: Any) {
        if ( a == nil && b == nil && c == nil ){
            a = 0.0
            firstOperator = .multiply
        }
            
        else if ( a != nil && b == nil && c == nil ){
            firstOperator = .multiply
        }
            
        else if ( a != nil && b != nil && c == nil ){
            if firstOperator == .add || firstOperator == .minus {
                secondOperator = .multiply
            }
            else {
                a = calculate(a!, b!, paraOperator: firstOperator)
                b = nil
                firstOperator = .multiply
                lblDisplay.text = String(a!)
            }
        }
            
        else if ( a != nil && b != nil && c != nil ){
            b = calculate(b!, c!, paraOperator: secondOperator)
            c = nil
            secondOperator = .multiply
            lblDisplay.text = String(b!)
        }
        
    }
    
    @IBAction func minusBtn(_ sender: Any) {
        if ( a == nil && b == nil && c == nil ){
            a = 0.0
            firstOperator = .minus
        }
            
        else if ( a != nil && b == nil && c == nil ){
            firstOperator = .minus
        }
        
        else if ( a != nil && b != nil && c == nil ){
            a = calculate(a!, b!, paraOperator: firstOperator)
            b = nil
            firstOperator = .minus
            lblDisplay.text = String(a!)
        }
            
        else if ( a != nil && b != nil && c != nil ){
            b = calculate(b!, c!, paraOperator: secondOperator)
            c = nil
            secondOperator = .null
            a = calculate(a!, b!, paraOperator: firstOperator)
            b = nil
            firstOperator = .minus
            lblDisplay.text = String(a!)
            
        }
        
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        if ( a == nil && b == nil && c == nil ){
            a = 0.0
            firstOperator = .add
        }
            
        else if ( a != nil && b == nil && c == nil ){
            firstOperator = .add
        }
        
        else if ( a != nil && b != nil && c == nil ){
            a = calculate(a!, b!, paraOperator: firstOperator)
            b = nil
            firstOperator = .add
            lblDisplay.text = String(a!)
        }
        
        else if ( a != nil && b != nil && c != nil ){
            b = calculate(b!, c!, paraOperator: secondOperator)
            c = nil
            secondOperator = .null
            a = calculate(a!, b!, paraOperator: firstOperator)
            b = nil
            firstOperator = .add
            lblDisplay.text = String(a!)
            
        }

    }
    
    @IBAction func equalBtn(_ sender: Any) {
        if firstOperator == .null && secondOperator == .null {
            
        }
            
        else if firstOperator != .null && secondOperator == .null {
            if a != nil && b != nil {
                a = calculate(a!, b!, paraOperator: firstOperator)
                b = nil
                firstOperator = .null
                lblDisplay.text = String(a!)
            }
        }
            
        else if firstOperator != .null && secondOperator != .null {
            if a != nil && b != nil && c != nil {
                if secondOperator == .multiply || secondOperator == .divide {
                    b = calculate(b!, c!, paraOperator: secondOperator)
                    c = nil
                    secondOperator = .null
                    a = calculate(a!, b!, paraOperator: firstOperator)
                    b = nil
                    firstOperator = .null
                    lblDisplay.text = String(a!)
                }
                else {
                    a = calculate(a!, b!, paraOperator: firstOperator)
                    b = nil
                    firstOperator = .null
                    a = calculate(a!, c!, paraOperator: secondOperator)
                    c = nil
                    secondOperator = .null
                    lblDisplay.text = String(a!)
                }
            }
        }
            
//        else if firstOperator == .null && secondOperator == .null {
//
//        }
        
    }
 
    
    @IBAction func pointBtn(_ sender: Any) {
        if ((lblDisplay.text?.rangeOfCharacter(from: CharacterSet(charactersIn: "."))) == nil){
            if lblDisplay.text!.count < 9 {
                lblDisplay.text! += "."
            }
        }
    }
    
    
    @IBOutlet var lblDisplay: UILabel!
    @IBOutlet var kbStackView: UIStackView!
    
    var a:Double?
    var b:Double?
    var c:Double?
    var firstOperator: Operation = .null
    var secondOperator: Operation = .null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //if lblDisplay != nil {
        lblDisplay.text = "0"
        
        
//        if self.view.frame.width > self.view.frame.height {
//            kbStackView.widthAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
//        }
//        else {
//            kbStackView.widthAnchor.constraint(equalToConstant: self.view.frame.height * 0.7).isActive = true
//        }

    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape:")
            print(self.view.bounds)
            print(self.view.frame.width)
            
        } else {
            print("Portrait:")
            print(self.view.bounds)
            print(self.view.frame.width)
            
        }
        
        if self.view.frame.width > self.view.frame.height {
            kbStackView.widthAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
        }
        else {
            kbStackView.widthAnchor.constraint(equalToConstant: self.view.frame.height * 0.3).isActive = true
        }
        
    }

}

