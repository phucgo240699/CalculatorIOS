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
    
    func setUpCircle(_ frame: CGRect){
        cp = CircularProgressView(frame: CGRect(x: frame.width * 0.2, y: frame.height/8, width: frame.width * 0.5, height: frame.width * 0.5))
        
        
        guard let cp = cp else {
            return
        }
        
        cp.trackLayer.strokeEnd = 0.0
        cp.progressColor = UIColor.lightGray
        
    }
    
    func setUpLine(_ frame: CGRect){
        line = LineProgressView(frame: CGRect(x: frame.width * 0.06, y: frame.height/4, width: frame.width * 0.8, height: view.frame.width * 0.05))
        
        
        guard let line = line else {
            return
        }
        
        line.trackLayer.strokeEnd = 0.0
        line.backgroundColor = UIColor.lightGray
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        toggleGradient = true
        
        // add PageViewController.view into view
        
        
        pageVC.view.frame.size = CGSize(width: pageView.frame.width, height: pageView.frame.height * 1.1)
        pageVC.view.frame.origin = CGPoint(x: 0.0, y: 0.0)

        
        print(pageView.bounds)
        print(pageVC.view.bounds)
        
//        self.addChild(pageVC)
//        self.view.addSubview(pageVC.view)
//        pageVC.didMove(toParent: self)
        pageView.addSubview(pageVC.view)
        
        setUpCircle(pageVC.subViewControllers[0].view.bounds)
        setUpLine(pageVC.subViewControllers[1].view.bounds)
        
        pageVC.subViewControllers.first?.view.addSubview(cp!)
        pageVC.subViewControllers[1].view.addSubview(line!)
        

        
    }
}

