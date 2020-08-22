//
//  LineProgressView.swift
//  Progressing
//
//  Created by Phúc Lý on 8/17/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation
import UIKit

class LineProgressView: UIView {
    
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
//        let width = frame.width
//        let height = frame.height
//        let lineWidth = min(width, height) * 0.1
//        let center = CGPoint(x: width/2, y: height/2)
//        let radius = (min(width, height) - lineWidth) / 2
//        let circlePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        let line = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
//        line.move(to: CGPoint(x: 0, y: frame.height))
//        line.addLine(to: CGPoint(x: frame.width, y: frame.height))
        trackLayer.path = line.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = frame.height
        trackLayer.strokeEnd = 0.0
        
        progressLayer.path = line.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = frame.height
        progressLayer.strokeEnd = 0.45
        
        
        gradientLayer = CAGradientLayer()
        guard let gradientLayer = gradientLayer else {
            return
        }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor]
        gradientLayer.frame = bounds
        gradientLayer.mask = trackLayer
        
        layer.mask = progressLayer
        layer.addSublayer(gradientLayer)
        
        
    }

}

