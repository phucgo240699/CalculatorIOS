//
//  UIView+Extension.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/22/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

extension UIView {
    // For insert layer in background
    func addBlackGradientLayerInBackground(frame: CGRect, colors:[UIColor]){
         let gradient = CAGradientLayer()
         gradient.frame = frame
         gradient.colors = colors.map{$0.cgColor}
         self.layer.insertSublayer(gradient, at: 0)
    }
}
