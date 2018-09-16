//
//  WalkThroughPVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/19/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

protocol WalkThroughPVCDelegate: class {
    
    /// Used to create a direct communication between the UIPageController and the controller wherever it's implemented.
    ///
    /// - Parameter currentIndex: The current index that is displayed by the UIPageController.
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkThroughPVC: UIPageViewController {
    
    //MARK: - VARIABLES
    
    var walkThroughPVC:WalkThroughPVC?
    var arrHeaders = ["WPC_H1".localized,
                      "WPC_H2".localized,
                      "WPC_H3".localized]
    var arrSubHeaders = ["WPC_SH1".localized,
                         "WPC_SH2".localized,
                         "WPC_SH3".localized]
    var arrImages = ["BGLogo",
                     "BGLogo",
                     "BGLogo"]
    var currentIndex = 0
    weak var walkThroughDelegate: WalkThroughPVCDelegate?
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let initialVC = getContentVC(at: 0){
            setViewControllers([initialVC],
                               direction: UIPageViewControllerNavigationDirection.forward,
                               animated: true,
                               completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    /// Used to obtain the corresponding WalkThroughContentVC according to the index sended.
    ///
    /// - Parameter index: The corresponding index for the view controller you need.
    /// - Returns: An optional WalkThroughContentVC initialized according to the index sended.
    func getContentVC(at index: Int)->WalkThroughContentVC?{
        
        if index < 0 || index >= arrHeaders.count{
            return nil
        }
        
        let storyboard = UIStoryboard(name: "Onboarding",
                                      bundle: nil)
        if let contentVC = storyboard.instantiateViewController(withIdentifier: "WalkThroughContentVC") as? WalkThroughContentVC{
            
            contentVC.strImageName = arrImages[index]
            contentVC.strHeader = arrHeaders[index]
            contentVC.strSubHeader = arrSubHeaders[index]
            contentVC.index = index
            
            return contentVC
        }
        
        return nil
    }
    
    /// Used to move forward between the current WalkThroughContentVC.
    func pageForward(){
        
        currentIndex += 1
        if let nextVC = getContentVC(at: currentIndex){
            setViewControllers([nextVC],
                               direction: UIPageViewControllerNavigationDirection.forward,
                               animated: true,
                               completion: nil)
        }
    }
    
}

//MARK: - EXTENSIONS

//MARK: - UIPageViewControllerDataSource & UIPageViewControllerDelegate

extension WalkThroughPVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkThroughContentVC).index
        index -= 1
        
        return getContentVC(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! WalkThroughContentVC).index
        index += 1
        
        return getContentVC(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed{
            
            if let contentVC = pageViewController.viewControllers?.first as? WalkThroughContentVC{
                
                currentIndex = contentVC.index
                walkThroughDelegate?.didUpdatePageIndex(currentIndex: contentVC.index)
            }
        }
    }
}
