//
//  DetailBoardViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/18/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class DetailBoardViewController: UIViewController {
    var pageVC = DetailBoardPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    var lists: [ListCardViewController] = [ListCardViewController(nibName: "ListCardViewController", bundle: nil), ListCardViewController(nibName: "ListCardViewController", bundle: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageVC.view.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        pageVC.view.frame.origin = CGPoint(x: 0.0, y: 0.0)
        
        for e in lists {
            pageVC.subViewControllers.append(e)
        }
        
        if let firstViewController = pageVC.subViewControllers.first {
            pageVC.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.view.addSubview(pageVC.view)
    }
    
    
}
