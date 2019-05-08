//
//  MyBadgesVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/5/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class MyBadgesVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var myBadgesPVC: MyBadgesPVC?
    var currentPageIndex: Int = 0
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var scBadges: UISegmentedControl!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.addImageLogoToNavBar()
        setupSegmentedControl()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? MyBadgesPVC{
            
            myBadgesPVC = destinationVC
            myBadgesPVC?.myBadgesDelegate = self
        }
    }
    
    //MARK: - FUNCTIONS
    
    func setupSegmentedControl() {
        scBadges.removeAllSegments()
        scBadges.selectedSegmentIndex = 0
        scBadges.insertSegment(withTitle: "BA_BRO".localized, at: 0, animated: false)
        scBadges.insertSegment(withTitle: "BA_SIL".localized, at: 1, animated: false)
        scBadges.insertSegment(withTitle: "BA_GOL".localized, at: 2, animated: false)
    }
    
    func updateUI() {
        
        if let index = myBadgesPVC?.currentIndex {
            
            scBadges.selectedSegmentIndex = index
        }
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actSCBadges(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex > currentPageIndex {
            myBadgesPVC?.pageForward(newIndex: sender.selectedSegmentIndex)
        } else if sender.selectedSegmentIndex < currentPageIndex {
            myBadgesPVC?.pageBackward(newIndex: sender.selectedSegmentIndex)
        }
        currentPageIndex = sender.selectedSegmentIndex
    }
}

//MARK: - EXTENSIONS

//MARK: - MyBadgesPVCDelegate

extension MyBadgesVC: MyBadgesPVCDelegate {
    
    func didUpdateIndex(currentIndex: Int) {
        
        currentPageIndex = currentIndex
        updateUI()
    }
}
