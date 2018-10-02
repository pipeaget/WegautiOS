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
        case onlyPrevious
        case both
        case finish
    }
    
    enum processProgressViewState {
        
        case general
        case location
        case schedule
        case sponsorship
        case multimedia
    }
    
    //MARK: - VARIABLES
    
    var currentViewState: processProgressViewState = processProgressViewState.general {
        didSet {
            updateUI()
        }
    }
    var currentStackState: stackState = stackState.onlyNext {
        didSet {
            updateStackView()
        }
    }
    var generalInfoVC: GeneralInfoVC?
    var locationInfoVC: LocationInfoVC?
    var scheduleInfoVC: ScheduleInfoVC?
    var sponsorshipInfoVC: SponsorshipInfoVC?
    var multimediaInfoVC: MultimediaInfoVC?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwProcess: UIView!
    @IBOutlet weak var lblStep1: UILabel!
    @IBOutlet weak var vwStep1: FORView!
    @IBOutlet weak var lblStep2: UILabel!
    @IBOutlet weak var vwStep2: FORView!
    @IBOutlet weak var vwConnector2: FORView!
    @IBOutlet weak var lblStep3: UILabel!
    @IBOutlet weak var vwStep3: FORView!
    @IBOutlet weak var vwConnector3: FORView!
    @IBOutlet weak var lblStep4: UILabel!
    @IBOutlet weak var vwStep4: FORView!
    @IBOutlet weak var vwConnector4: FORView!
    @IBOutlet weak var lblStep5: UILabel!
    @IBOutlet weak var vwStep5: FORView!
    @IBOutlet weak var vwConnector5: FORView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var svwProcessProgress: UIStackView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        lblStep1.text = "ANE_STEP1".localized
        lblStep2.text = "ANE_STEP2".localized
        lblStep3.text = "ANE_STEP3".localized
        lblStep4.text = "ANE_STEP4".localized
        lblStep5.text = "ANE_STEP5".localized
        btnPrevious.setTitle("ANE_PREV".localized,
                             for: UIControl.State.normal)
        btnNext.setTitle("ANE_NEXT".localized,
                         for: UIControl.State.normal)
        currentViewState = processProgressViewState.general
        currentStackState = stackState.onlyNext
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    func updateUI() {
        
        switch currentViewState {
            
        case .general:
            manageChildVC()
            vwStep1.isActive = true
            
        case .location:
            manageChildVC()
            vwStep2.isActive = true
            vwConnector2.isActive = true
            
        case .schedule:
            manageChildVC()
            vwStep3.isActive = true
            vwConnector3.isActive = true
            
        case .sponsorship:
            manageChildVC()
            vwStep4.isActive = true
            vwConnector4.isActive = true
            
        case .multimedia:
            manageChildVC()
            vwStep4.isActive = true
            vwConnector4.isActive = true
        }
    }
    
    /// Used to manage the subviews and it's memory managment.
    func manageChildVC() {
        
        let storyboard = UIStoryboard(name: "AddNewEvent",
                                      bundle: Bundle.main)
        
        switch currentViewState {
            
        case .general:
            guard let vc: GeneralInfoVC = storyboard.instantiateViewController(withIdentifier: "GeneralInfoVC") as? GeneralInfoVC else {
                
                return
            }
            generalInfoVC = vc
            self.addVCasChildVC(childVC: vc)
            
        case .location:
            guard let vc: LocationInfoVC = storyboard.instantiateViewController(withIdentifier: "LocationInfoVC") as? LocationInfoVC else {
                
                return
            }
            locationInfoVC = vc
            self.addVCasChildVC(childVC: vc)
            removeViewControllerAsChildViewController(childVC: generalInfoVC)
            
        case .schedule:
            guard let vc: ScheduleInfoVC = storyboard.instantiateViewController(withIdentifier: "ScheduleInfoVC") as? ScheduleInfoVC else {
                
                return
            }
            scheduleInfoVC = vc
            self.addVCasChildVC(childVC: vc)
            removeViewControllerAsChildViewController(childVC: locationInfoVC)
            
        case .sponsorship:
            guard let vc: SponsorshipInfoVC = storyboard.instantiateViewController(withIdentifier: "SponsorshipInfoVC") as? SponsorshipInfoVC else {
                
                return
            }
            sponsorshipInfoVC = vc
            self.addVCasChildVC(childVC: vc)
            removeViewControllerAsChildViewController(childVC: scheduleInfoVC)
            
        case .multimedia:
            guard let vc: MultimediaInfoVC = storyboard.instantiateViewController(withIdentifier: "MultimediaInfoVC") as? MultimediaInfoVC else {
                
                return
            }
            multimediaInfoVC = vc
            self.addVCasChildVC(childVC: vc)
            removeViewControllerAsChildViewController(childVC: sponsorshipInfoVC)
            
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
            btnPrevious.isHidden = true
            btnNext.setTitle("ANE_NEXT".localized,
                             for: UIControl.State.normal)
            
        case .onlyPrevious:
            btnNext.isHidden = true
            btnPrevious.isHidden = false
            
        case .both:
            btnNext.isHidden = false
            btnPrevious.isHidden = false
            btnNext.setTitle("ANE_NEXT".localized,
                             for: UIControl.State.normal)
            
        case .finish:
            btnNext.isHidden = false
            btnPrevious.isHidden = false
            btnNext.setTitle("ANE_FIN".localized,
                             for: UIControl.State.normal)
        }
    }
    
    func setProgressStateUIFor(index: Int) {
        
        for subview in vwProcess.subviews {
            
            if let aView = subview as? FORView {
                
                aView.isActive = aView.tag <= index ?  true : false
            }
        }
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actPreviousStep(_ sender: UIButton) {
        
        switch currentViewState {
            
        case .location:
            setProgressStateUIFor(index: 1)
            currentViewState = processProgressViewState.general
            currentStackState = stackState.onlyNext
            
        case .schedule:
            setProgressStateUIFor(index: 2)
            currentViewState = processProgressViewState.location
            currentStackState = stackState.both
            
        case .sponsorship:
            setProgressStateUIFor(index: 3)
            currentViewState = processProgressViewState.schedule
            currentStackState = stackState.both
            
        case .multimedia:
            setProgressStateUIFor(index: 4)
            currentViewState = processProgressViewState.sponsorship
            currentStackState = stackState.both
            
        default:
            break
        }
    }
    
    
    @IBAction func actNextStep(_ sender: UIButton) {
        
        switch currentViewState {
            
        case .general:
            setProgressStateUIFor(index: 2)
            currentViewState = processProgressViewState.location
            currentStackState = stackState.both
            
        case .location:
            setProgressStateUIFor(index: 3)
            currentViewState = processProgressViewState.schedule
            currentStackState = stackState.both
            
        case .schedule:
            setProgressStateUIFor(index: 4)
            currentViewState = processProgressViewState.sponsorship
            currentStackState = stackState.both
            
        case .sponsorship:
            setProgressStateUIFor(index: 5)
            currentViewState = processProgressViewState.multimedia
            currentStackState = stackState.finish
            
        default:
            break
        }
    }
}
