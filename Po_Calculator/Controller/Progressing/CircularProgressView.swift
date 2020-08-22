//
//  CircularProgressView.swift
//  Progressing
//
//  Created by Phúc Lý on 8/16/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class CircularProgressView: UIView {
    
    var progressLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    
    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    
    fileprivate func createCircularPath() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = frame.width/2
        let width = frame.width
        let height = frame.height
        let lineWidth = min(width, height) * 0.1
        let center = CGPoint(x: width/2, y: height/2)
        let radius = (min(width, height) - lineWidth) / 2
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        
            
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 10.0
        trackLayer.strokeEnd = 0.0
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 1.0
        
        layer.addSublayer(progressLayer)
        
        gradientLayer = CAGradientLayer()
        guard let gradientLayer = gradientLayer else {
            return
        }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [UIColor.red.cgColor,  UIColor.green.cgColor, UIColor.blue.cgColor ]
        gradientLayer.frame = bounds
        gradientLayer.mask = trackLayer
        
        layer.addSublayer(gradientLayer)
    }

}
