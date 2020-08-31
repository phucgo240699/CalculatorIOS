//
//  ProgressingViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/17/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class ProgressingViewController: UIViewController {
    
    @IBOutlet weak var pageView: UIView!
    
    let pageVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    var cp: CircularProgressView?
    var line: LineProgressView?
    
    var timer: Timer?
    var logicline1:Bool = true
    var logicCircle1: Bool = true
    var toggleGradient:Bool = true
    
    @IBOutlet weak var startBtnPressed: UIButton!
    @IBAction func startBtn(_ sender: UIButton) {
        timer?.invalidate()
        timer = nil
        logicline1 = true
        logicCircle1 = true
        self.line?.trackLayer.strokeEnd = 0.0
        self.cp?.trackLayer.strokeEnd = 0.0
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (t) in
                // line? 1
                if self.line!.trackLayer.strokeEnd >= self.line!.progressLayer.strokeEnd {
                    self.logicline1 = false
                }
                self.line?.trackLayer.strokeEnd += 0.01
                        
                // circle 1
                if self.cp!.trackLayer.strokeEnd >= self.cp!.progressLayer.strokeEnd {
                    self.logicCircle1 = false
                }
                self.cp?.trackLayer.strokeEnd += 0.022
                        
                if self.logicline1 == false && self.logicCircle1 == false {
                    t.invalidate()
                    self.logicline1 = true
                    self.logicCircle1 = true
                    return
                }
            }
    }
    
    @IBAction func toggleGradient(_ sender: UIBarButtonItem) {
        if toggleGradient == true {
            self.cp?.gradientLayer?.colors = [ UIColor.systemPink.cgColor, UIColor.systemPink.cgColor ]
            self.line?.gradientLayer?.colors = [ UIColor.systemPink.cgColor, UIColor.systemPink.cgColor ]
            
            sender.image = UIImage(systemName: "eye.slash")
            toggleGradient = false
        }
        else {
            self.cp?.gradientLayer?.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.systemPink.cgColor]
            self.line?.gradientLayer?.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor]
            
            toggleGradient = true
            sender.image = UIImage(systemName: "eye")
        }
    }
    
    func setUpCircle(_ parentView: UIView){
        cp = CircularProgressView(frame: CGRect(x: 0, y: 0, width: parentView.bounds.width * 0.5, height: parentView.bounds.width * 0.5))
        
        guard let cp = cp else {
            return
        }
        
        parentView.addSubview(cp)
        cp.trackLayer.strokeEnd = 0.0
        cp.progressColor = UIColor.lightGray
        
        cp.translatesAutoresizingMaskIntoConstraints = false
        cp.widthAnchor.constraint(equalToConstant: parentView.bounds.width * 0.5).isActive = true
        cp.heightAnchor.constraint(equalToConstant: parentView.bounds.width * 0.5).isActive = true
        cp.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        cp.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
    }
    
    func setUpLine(_ parentView: UIView){
        line = LineProgressView(frame: CGRect(x: parentView.bounds.width * 0.05, y: 0, width: parentView.bounds.width * 0.9, height: parentView.bounds.width * 0.04))
        
        
        guard let line = line else {
            return
        }
        
        parentView.addSubview(line)
        line.trackLayer.strokeEnd = 0.0
        line.backgroundColor = UIColor.lightGray
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.widthAnchor.constraint(equalToConstant: parentView.bounds.width * 0.9).isActive = true
        line.heightAnchor.constraint(equalToConstant: parentView.bounds.width * 0.04).isActive = true
        line.centerXAnchor.constraint(equalTo: parentView.centerXAnchor).isActive = true
        line.centerYAnchor.constraint(equalTo: parentView.centerYAnchor).isActive = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let widthView = view.bounds.width
        let heightView = view.bounds.height
        var edgeSize:CGFloat = widthView
        if widthView < heightView {
            edgeSize = widthView * 0.8
        }
        else {
            edgeSize = heightView * 0.7
        }
        
        pageView.translatesAutoresizingMaskIntoConstraints = false
        pageView.widthAnchor.constraint(equalToConstant: edgeSize).isActive = true
        pageView.heightAnchor.constraint(equalToConstant: edgeSize).isActive = true
        pageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
                
        toggleGradient = true
        
        pageView.addSubview(pageVC.view)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.view.widthAnchor.constraint(equalToConstant: pageView.bounds.width).isActive = true
        pageVC.view.heightAnchor.constraint(equalToConstant: pageView.bounds.width).isActive = true
        pageVC.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageVC.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        setUpCircle(pageVC.subViewControllers[0].view)
        setUpLine(pageVC.subViewControllers[1].view)
        
    }
}

