//
//  WalkThroughVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/19/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class WalkThroughVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var walkThroughPVC:WalkThroughPVC?
    
    //MARK: - OUTLETS
    
    @IBOutlet var pcWalkThrough: UIPageControl!
    @IBOutlet var btnNext: UIButton!{
        didSet{
            
            btnNext.layer.cornerRadius = 25.0
            btnNext.layer.masksToBounds = true
        }
    }
    @IBOutlet var btnSkip: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        btnNext.setTitle("WAL_NXT".localized, for: UIControl.State.normal)
        btnSkip.setTitle("WAL_SKP".localized, for: UIControl.State.normal)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? WalkThroughPVC{
            
            walkThroughPVC = destinationVC
            walkThroughPVC?.walkThroughDelegate = self
        }
    }
    
    //MARK: - FUNCTIONS
    
    /// Used to update the user interface according to the current index displayed by the pcWalkThrough.
    func updateUI(){
        
        if let index = walkThroughPVC?.currentIndex{
            
            switch index{
                
            case 0...1:
                btnNext.setTitle("WAL_NXT".localized,
                                 for: UIControl.State.normal)
                btnSkip.isHidden = false
                
            case 2:
                btnNext.setTitle("WAL_STA".localized,
                                 for: UIControl.State.normal)
                btnSkip.isHidden = true
                
            default:
                break
            }
            
            pcWalkThrough.currentPage = index
        }
    }
    
    //MARK: - ACTIONS
    
    /// Used to dismiss the walk through and don`t show it again.
    ///
    /// - Parameter sender: btnSkip
    @IBAction func actSkip(sender: UIButton){
        
        UserDefaults.standard.set(false,
                                  forKey: WegautConstants.DISPLAY_TUTORIAL)
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    /// Used to manage the user interface according to the corresponding index displayed.
    ///
    /// - Parameter sender: btnNext
    @IBAction func actNext(sender: UIButton){
        
        if let index = walkThroughPVC?.currentIndex{
            
            switch index{
                
            case 0...1:
                walkThroughPVC?.pageForward()
                
            case 2:
                UserDefaults.standard.set(false,
                                          forKey: WegautConstants.DISPLAY_TUTORIAL)
                dismiss(animated: true,
                        completion: nil)
                
            default:
                break
            }
        }
        updateUI()
    }
}

//MARK: - EXTENSIONS

//MARK: - WalkThroughPVCDelegate

extension WalkThroughVC: WalkThroughPVCDelegate{
    
    func didUpdatePageIndex(currentIndex: Int) {
        
        updateUI()
    }
}
