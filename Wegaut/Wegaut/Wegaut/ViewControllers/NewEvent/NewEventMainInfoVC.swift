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
    @IBOutlet weak var btnNewImage: UIButton!
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
        ccEventName.tfInput.delegate = self
        ccEventName.strPlaceholder = "NEMI_ENAME".localized
        ccEventAccesType.tfInput.delegate = self
        ccEventAccesType.strPlaceholder = "NEMI_ACCT".localized
        ccEventAgeRange.tfInput.delegate = self
        ccEventAgeRange.strPlaceholder = "NEMI_AGER".localized
        ccEventDate.tfInput.delegate = self
        ccEventDate.strPlaceholder = "NEMI_DATE".localized
        lblEventDescription.text = "NEMI_ABO".localized
        txtvwEventDescription.text = "NEMI_EXA".localized
        txtvwEventDescription.textColor = UIColor.textColor
        txtvwEventDescription.delegate = self
        lblDescriptionCount.text = "0/250"
    }
    
    //MARK: - FUNCTIONS
    
    //MARK: - ACTIONS

    @IBAction func actNewImage(_ sender: UIButton) {
        
        //TODO: 
    }
}

//MARK: - EXTENSIONS

extension NewEventMainInfoVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
            
        case ccEventName.tfInput:
            ccEventName.activePlaceholder()
            
        case ccEventAccesType.tfInput:
            ccEventAccesType.activePlaceholder()
            //TODO: SHOW ACCESS TYPE POP
            break
            
        case ccEventAgeRange.tfInput:
            ccEventAgeRange.activePlaceholder()
            //TODO: SHOW AGE RANGR POP
            break
            
        case ccEventDate.tfInput:
            ccEventDate.activePlaceholder()
            //TODO: SHOW DATE POP
            break
            
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case ccEventName.tfInput: ccEventAccesType.becomeFirstResponder()
            
        case ccEventAccesType.tfInput: ccEventAgeRange.becomeFirstResponder()
            
        case ccEventAgeRange.tfInput: ccEventDate.becomeFirstResponder()
            
        case ccEventDate.tfInput: self.dismissKeyboard()
            
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
            
        case ccEventName.tfInput:
            ccEventName.deactivatePlaceholder()
            break
            
        case ccEventAccesType.tfInput:
            ccEventAccesType.deactivatePlaceholder()
            break
            
        case ccEventAgeRange.tfInput:
            ccEventAgeRange.deactivatePlaceholder()
            break
            
        case ccEventDate.tfInput:
            ccEventDate.deactivatePlaceholder()
            break
            
        default:
            break
        }
    }
}

extension NewEventMainInfoVC: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        
        txtvwEventDescription.textColor = UIColor.textColor
        if txtvwEventDescription.text.hasPrefix("NEMI_PREF".localized) {
            
            textView.text = ""
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let strCurrent: String = textView.text ?? ""
        guard let strRange = Range(range,
                                   in: strCurrent) else { return false }
        let strUpdate = strCurrent.replacingCharacters(in: strRange,
                                                       with: text)
        switch strUpdate.count {
            
        case 0...248:
            lblDescriptionCount.textColor = UIColor.textColor
            lblDescriptionCount.text = "\(textView.text.count + text.count)/250"
            return true
            
        case 249:
            lblDescriptionCount.textColor = UIColor.red
            lblDescriptionCount.text = "\(textView.text.count + text.count)/250"
            return true
            
        default:
            return false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.hasPrefix("NEMI_PREF".localized) {
            
            textView.text = "NEMI_EXA".localized
            textView.textColor = UIColor.textColor
        }
    }
}
