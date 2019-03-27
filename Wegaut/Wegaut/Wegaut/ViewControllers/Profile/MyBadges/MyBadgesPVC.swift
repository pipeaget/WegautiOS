//
//  MyBadgesPVC.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/23/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol MyBadgesPVCDelegate: class {
    
    /// Used to create a direct communication between the UIPageController and the controller wherever it's implemented.
    ///
    /// - Parameter currentIndex: The current index that is displayed by the UIPageController.
    func didUpdateIndex(currentIndex: Int)
}

class MyBadgesPVC: UIPageViewController {
    
    //MARK: - VARIABLES
    
    var mybadgesPVC: MyBadgesPVC?
    var arrHeaders: [String] = ["", "", ""]
    var currentIndex: Int = 0 {
        didSet {
            getContentVC(at: currentIndex)
        }
    }
    weak var myBadgesDelegate: MyBadgesPVCDelegate?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let initialVC = getContentVC(at: 0){
            setViewControllers([initialVC],
                               direction: UIPageViewController.NavigationDirection.forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    //MARK: - FUNCTIONS
    
    /// Used to obtain the corresponding WalkThroughContentVC according to the index sended.
    ///
    /// - Parameter index: The corresponding index for the view controller you need.
    /// - Returns: An optional WalkThroughContentVC initialized according to the index sended.
    func getContentVC(at index: Int) -> MyBadgesContainerVC? {
        
        if index < 0 || index >= arrHeaders.count{
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        if let contentVC = storyboard.instantiateViewController(withIdentifier: "MyBadgesContainerVC") as? MyBadgesContainerVC {
            
            contentVC.index = index
            return contentVC
        }
        
        return nil
    }
    
    /// Used to move forward between the current WalkThroughContentVC.
    func pageForward(newIndex: Int) {
        
        currentIndex = newIndex
        if let nextVC = getContentVC(at: currentIndex){
            setViewControllers([nextVC],
                               direction: UIPageViewController.NavigationDirection.forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    func pageBackward(newIndex: Int) {
        
        currentIndex = newIndex
        if let nextVC = getContentVC(at: currentIndex){
            setViewControllers([nextVC],
                               direction: UIPageViewController.NavigationDirection.reverse,
                               animated: true,
                               completion: nil)
        }
    }
}

//MARK: - EXTENSIONS

extension MyBadgesPVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! MyBadgesContainerVC).index
        index -= 1
        
        return getContentVC(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! MyBadgesContainerVC).index
        index += 1
        
        return getContentVC(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed{
            
            if let contentVC = pageViewController.viewControllers?.first as? MyBadgesContainerVC{
                
                currentIndex = contentVC.index
                myBadgesDelegate?.didUpdateIndex(currentIndex: contentVC.index)
            }
        }
    }
}
