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
    
    var currentEvent: Event!
    
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
        currentEvent = Event.getNewEvent()
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
            break
            
        case ccEventAgeRange.tfInput:
            ccEventAgeRange.activePlaceholder()
            //TODO: SHOW AGE RANGE POP
            break
            
        case ccEventDate.tfInput:
            ccEventDate.activePlaceholder()
            //TODO: SHOW DATE POP
            break
            
        default:
            break
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case ccEventAccesType.tfInput:
            dismissKeyboard()
            let popUpAlert: FORPopUpView = FORPopUpView(with: FORAlertData(filterOptions: nil,
                                                                           aTitle: "NEMI_TITACCTYP".localized,
                                                                           aMessage: nil,
                                                                           yesButtonTitle: "OK".localized,
                                                                           yesButtonColor: UIColor.deepPurple,
                                                                           noButtonTitle: "CANCEL".localized,
                                                                           noButtonColor: UIColor.mediumPurple,
                                                                           selectOptions: AssistantType.getAllAsistantTypes()))
            popUpAlert.yesNoSuccess = {
                aBool in
                if aBool {
                    self.ccEventAccesType.tfInput.text = AssistantType.getAssistantTypeFrom(index: popUpAlert.selectedSegmentIndex ?? 0).description
                    popUpAlert.dismiss(animated: true)
                }
            }
            popUpAlert.show(animated: true)
            return false
            
        case ccEventAgeRange:
            dismissKeyboard()
            let popUpAlert: FORPopUpView = FORPopUpView(with: FORAlertData(filterOptions: nil,
                                                                           aTitle: "NEMI_TITAGERAN".localized,
                                                                           aMessage: nil,
                                                                           yesButtonTitle: "OK".localized,
                                                                           yesButtonColor: UIColor.deepPurple,
                                                                           noButtonTitle: "CANCEL".localized,
                                                                           noButtonColor: UIColor.mediumPurple,
                                                                           selectOptions: AgeRange.getAllAgeRanges()))
            popUpAlert.yesNoSuccess = {
                aBool in
                if aBool {
                    self.ccEventAgeRange.tfInput.text = AgeRange.getAgeRangeFrom(index: popUpAlert.selectedSegmentIndex ?? 0).description
                    popUpAlert.dismiss(animated: true)
                }
            }
            popUpAlert.show(animated: true)
            return false
            
        case ccEventDate.tfInput:
            dismissKeyboard()
            let popUpAlert: FORPopUpView = FORPopUpView(with: FORAlertData(datePicker: nil,
                                                                           aTitle: "NEMI_TITDATE".localized,
                                                                           aMessage: nil,
                                                                           yesButtonTitle: "OK".localized,
                                                                           yesButtonColor: UIColor.deepPurple,
                                                                           noButtonTitle: "CANCEL".localized,
                                                                           noButtonColor: UIColor.mediumPurple))
            popUpAlert.dateSelection = {
                
                aDate in
                self.ccEventDate.tfInput.text = aDate.description
                popUpAlert.dismiss(animated: true)
            }
            popUpAlert.show(animated: true)
            return false
            
        default: return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case ccEventName.tfInput: ccEventAccesType.tfInput.becomeFirstResponder()
            
        case ccEventAccesType.tfInput: ccEventAgeRange.tfInput.becomeFirstResponder()
            
        case ccEventAgeRange.tfInput: ccEventDate.tfInput.becomeFirstResponder()
            
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
