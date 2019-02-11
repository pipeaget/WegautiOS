//
//  AddNewEventVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/12/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class AddNewEventVC: UIViewController {
    
    //MARK: - ENUMS
    
    enum stackState {
        
        case onlyNext
        case finish
    }
    
    enum processProgressViewState {
        
        case mainInfo
        case otherInfo
    }
    
    //MARK: - VARIABLES
    
    var currentStackState: stackState = stackState.onlyNext {
        didSet {
            updateStackView()
        }
    }
    var currentViewState: processProgressViewState = processProgressViewState.mainInfo {
        didSet {
            updateUI()
        }
    }
    var newEventMainInfoVC: NewEventMainInfoVC?
    var newEventOtherInfoVC: NewEventOtherInfoVC?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var svwProcessProgress: UIStackView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        btnNext.cornerRadius(cornerRadius: 5)
        btnNext.cornerRadius(cornerRadius: 5)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        btnPrevious.setTitle("NEMI_PREV".localized,
                             for: UIControl.State.normal)
        btnNext.setTitle("NEMI_NEXT".localized,
                         for: UIControl.State.normal)
        currentViewState = processProgressViewState.mainInfo
        currentStackState = stackState.onlyNext
        self.addImageLogoToNavBar()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    func updateUI() {
        
        manageChildVC()
    }
    
    /// Used to manage the subviews and it's memory managment.
    func manageChildVC() {
        
        let storyboard = UIStoryboard(name: "AddNewEvent",
                                      bundle: Bundle.main)
        
        switch currentViewState {
            
        case .mainInfo:
            guard let vc: NewEventMainInfoVC = storyboard.instantiateViewController(withIdentifier: "MainEventInfoVC") as? NewEventMainInfoVC else {
                
                return
            }
            vc.actValidateMainInfo = {
                
                aBool in
                self.svwProcessProgress.isHidden = false
            }
            newEventMainInfoVC = vc
            self.addVCasChildVC(childVC: vc)
            
        case .otherInfo:
            guard let vc: NewEventOtherInfoVC = storyboard.instantiateViewController(withIdentifier: "NewEventOtherInfoVC") as? NewEventOtherInfoVC else {
                
                return
            }
            vc.actValidateOtherInfo = {
                
                aBool in
                self.svwProcessProgress.isHidden = false
            }
            newEventOtherInfoVC = vc
            self.addVCasChildVC(childVC: vc)
            removeViewControllerAsChildViewController(childVC: newEventMainInfoVC)
        }
    }
    
    /// Used to add a view controller as a child view controller of this view controller.
    ///
    /// - Parameter childVC: The view controller that you want to add as a child view controller.
    func addVCasChildVC(childVC: UIViewController){
        
        if childVC.parent == nil{
            addChild(childVC)
            vwContainer.addSubview(childVC.view)
            childVC.view.frame = vwContainer.bounds
            childVC.view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
            //self.svwProcessProgress.isHidden = true
            childVC.didMove(toParent: self)
        }
    }
    
    /// Used to remove a view controller as a child view controller of this view controller.
    ///
    /// - Parameter childVC: The view controller that you want to remove as a child view controller.
    func removeViewControllerAsChildViewController(childVC: UIViewController?) {
        
        guard let vc = childVC else{
            
            return
        }
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    func updateStackView() {
        
        switch currentStackState {
            
        case .onlyNext:
            btnNext.isHidden = false
            btnNext.setTitle("NEMI_NEXT".localized,
                             for: UIControl.State.normal)
            btnPrevious.isHidden = true
            
        case .finish:
            btnNext.isHidden = false
            btnNext.setTitle("NEMI_FIN".localized,
                             for: UIControl.State.normal)
            btnPrevious.isHidden = false
        }
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actPreviousStep(_ sender: UIButton) {
        
        switch currentViewState {
            
        case .otherInfo:
            currentViewState = processProgressViewState.mainInfo
            currentStackState = stackState.onlyNext
            
        default:
            break
        }
    }
    
    
    @IBAction func actNextStep(_ sender: UIButton) {
        
        switch currentViewState {
            
        case .mainInfo:
            currentViewState = processProgressViewState.otherInfo
            currentStackState = stackState.finish
            
        default:
            break
        }
    }
}
