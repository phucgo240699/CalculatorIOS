//
//  DetailBoardPageViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/19/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class DetailBoardPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//
//
//        let preIndex = subViewControllers.firstIndex(of: previousViewControllers[0] as! ListCardViewController)
//        if let preIndex = preIndex {
//            if preIndex == 0 {
//                currentPageIndex = 1
//            }
//            else if preIndex == subViewControllers.count - 1 {
//                currentPageIndex = subViewControllers.count - 2
//            }
//            else {
//                if preIndex == currentPageIndex {
//                    currentPageIndex = preIndex - 1
//                }
//                else if preIndex > currentPageIndex {
//                    currentPageIndex -= 1
//                }
//                else if preIndex < currentPageIndex {
//
//                }
//            }
//        }
//
//
//
//    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
            return subViewControllers.count
        }
        
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = subViewControllers.firstIndex(of: firstViewController as! ListCardViewController) else {
                return 0
            }
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if subViewControllers.count <= 0 {
            return nil
        }
        
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController as! ListCardViewController) ?? 0
        
        if currentIndex <= 0 {
            if isFirstTimeAfter == false && isFirstTimeBefore == false {
                currentPageIndex = currentIndex
            }
            if isFirstTimeBefore == true {
                isFirstTimeBefore = false
            }
            return nil
        }
        
        
        if isFirstTimeBefore == true {
            isFirstTimeBefore = false
        }
        
        if isFirstTimeAfter == false && isFirstTimeBefore == false {
            currentPageIndex = currentIndex
        }
        
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if subViewControllers.count <= 0 {
            return nil
        }
        
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController as! ListCardViewController) ?? 0
        
        if currentIndex >= subViewControllers.count - 1 {
            if isFirstTimeAfter == false && isFirstTimeBefore == false {
                currentPageIndex = currentIndex
            }

            if isFirstTimeAfter == true {
                isFirstTimeAfter = false
            }
            return nil
        }
        
        if isFirstTimeAfter == true {
            isFirstTimeAfter = false
        }
        
        if isFirstTimeAfter == false && isFirstTimeBefore == false {
            currentPageIndex = currentIndex
        }
        
        return subViewControllers[currentIndex + 1]
    }
        
    var currentPageIndex: Int = 0
    lazy var subViewControllers: [ListCardViewController] = {
        return []
    }()
    var isFirstTimeAfter: Bool = true
    var isFirstTimeBefore: Bool = true
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
    }
    

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

}
