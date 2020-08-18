//
//  PageViewController.swift
//  Po_Calculator
//
//  Created by Phúc Lý on 8/17/20.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = subViewControllers.firstIndex(of: firstViewController) else {
                return 0
            }
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        return currentIndex <= 0 ? nil : subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        return currentIndex >= subViewControllers.count - 1 ? nil : subViewControllers[currentIndex+1]
    }
    
    lazy var subViewControllers: [UIViewController] = {
       return [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CircleProgressViewController") as! CircleProgressViewController,
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LineProgressViewController") as! LineProgressViewController
        ]
    }()
    
//    func createCarouselItemControler(with titleText: String?, with color: UIColor?) -> UIViewController {
//        let c = UIViewController()
//        c.view = PageViewController()
//
//        return c
//    }
//    
//    func populateItems() {
//        let text = ["🎖", "👑", "🥇"]
//        let backgroundColor:[UIColor] = [.blue, .red, .green]
//        
//        for (index, t) in text.enumerated() {
//            let c = createCarouselItemControler(with: t, with: backgroundColor[index])
//            items.append(c)
//        }
//    }
//    
//    func decoratePageControl() {
//        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselPageViewController.self])
//        pc.currentPageIndicatorTintColor = .orange
//        pc.pageIndicatorTintColor = .gray
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
//        decoratePageControl()
//        
//        populateItems()

        // Do any additional setup after loading the view.
        if let firstViewController = subViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
