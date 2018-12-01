//
//  NewEventMainInfoVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/29/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class NewEventMainInfoVC: UIViewController {
    
    //MARK: - VARIABLES
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwEventImage: UIImageView!
    @IBOutlet weak var btnNewImage: FORButton!
    @IBOutlet weak var ccEventName: FORAndroidTextfield!
    @IBOutlet weak var ccEventAccesType: FORAndroidTextfield!
    @IBOutlet weak var ccEventAgeRange: FORAndroidTextfield!
    @IBOutlet weak var ccEventDate: FORAndroidTextfield!
    @IBOutlet weak var lblEventDescription: UILabel!
    @IBOutlet weak var txtvwEventDescription: UITextView!
    @IBOutlet weak var lblDescriptionCount: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        btnNewImage.imageView?.contentMode = UIView.ContentMode.center
        ccEventName.placeholder = "NEMI_ENAME".localized
        ccEventName.tfInput.delegate = self
        ccEventAccesType.placeholder = "NEMI_ACCT".localized
        ccEventAccesType.tfInput.delegate = self
        ccEventAgeRange.placeholder = "NEMI_AGER".localized
        ccEventAgeRange.tfInput.delegate = self
        ccEventDate.placeholder = "NEMI_DATE".localized
        ccEventDate.tfInput.delegate = self
        lblEventDescription.text = "NEMI_ABO".localized
        txtvwEventDescription.text = "NEMI_EXA".localized
        txtvwEventDescription.textColor = UIColor.textColor
        txtvwEventDescription.delegate = self
        lblDescriptionCount.text = "0/250"
    }
    
    //MARK: - FUNCTIONS
    
    //MARK: - ACTIONS

}

//MARK: - EXTENSIONS

extension NewEventMainInfoVC: UITextFieldDelegate {
    
    
}

extension NewEventMainInfoVC: UITextViewDelegate {
    
}
