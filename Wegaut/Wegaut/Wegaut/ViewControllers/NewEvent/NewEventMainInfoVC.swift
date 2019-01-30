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
    var activeField: UITextField?
    var keyBoardHeight: CGFloat = 0
    var eventImage: UIImage?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var svContainer: UIScrollView!
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
        txtvwEventDescription.cornerRadius(cornerRadius: 5)
        txtvwEventDescription.layer.borderWidth = 1
        txtvwEventDescription.layer.borderColor = UIColor.lightGray.cgColor
        txtvwEventDescription.delegate = self
        
        lblDescriptionCount.text = "0/250"
        
        btnNewImage.contentMode = UIView.ContentMode.scaleAspectFill
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    //MARK: - NOTIFICATION CENTER
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if let activeField = self.activeField {
            
            keyBoardHeight = keyboardSize.height
            let contentInsets = UIEdgeInsets(top: 0.0,
                                             left: 0.0,
                                             bottom: keyboardSize.height,
                                             right: 0.0)
            self.svContainer.contentInset = contentInsets
            self.svContainer.scrollIndicatorInsets = contentInsets
            var aRect = self.svContainer.frame
            aRect.size.height -= keyboardSize.size.height
            if !aRect.contains(activeField.frame.origin){
                
                self.svContainer.scrollRectToVisible(activeField.frame,
                                                     animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: 0,
                                         right: 0.0)
        self.svContainer.contentInset = contentInsets
        self.svContainer.scrollIndicatorInsets = contentInsets
        let point =  CGPoint.zero
        self.svContainer.setContentOffset(point,
                                          animated: true)
    }
    
    //MARK: - FUNCTIONS
    
    func adjustKeyboardToShowTextView(){
        
        self.svContainer.scrollRectToVisible(lblDescriptionCount.frame,
                                             animated: true)
    }
    
    /// Used to get a selected image from the Photo Library
    func getImageFromPhotoLibrary() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker,
                     animated: true,
                     completion: nil)
    }
    
    /// Used to call camera view and get the taken image
    func getImageFromCamera() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.delegate = self
        self.present(imagePicker,
                     animated: true,
                     completion: nil)
    }
    
    //MARK: - ACTIONS

    @IBAction func actNewImage(_ sender: UIButton) {
        
        let alert = UIAlertController(title: nil,
                                      message: "REG_PHOTOMSSG".localized,
                                      preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "REG_CANCEL".localized,
                                         style: .cancel,
                                         handler: nil)
        let cameraAction = UIAlertAction(title: "REG_CAMERA".localized,
                                         style: .default,
                                         handler: {
                                            (alertaction) in
                                            self.getImageFromCamera()
        })
        let galleryAction = UIAlertAction(title: "REG_GALLERY".localized,
                                          style: .default,
                                          handler: {
                                            (alertaction) -> Void in
                                            self.getImageFromPhotoLibrary()
        })
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}

//MARK: - EXTENSIONS

extension NewEventMainInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            
            eventImage = selectedImage
            btnNewImage.setImage(eventImage,
                                    for: UIControl.State.normal)
            btnNewImage.backgroundColor = UIColor.clear
        }
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
}

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
        
        activeField = textField
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
                } else {
                    
                    popUpAlert.dismiss(animated: true)
                }
            }
            popUpAlert.show(animated: true)
            return false
            
        case ccEventAgeRange.tfInput:
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
                } else {
                    
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
            popUpAlert.yesNoSuccess = {
                
                aBool in
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
        
        adjustKeyboardToShowTextView()
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.size.width,
                                                        height: 44))
        let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                                            target: self,
                                                            action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "OK",
                                                         style: UIBarButtonItem.Style.done,
                                                         target: self,
                                                         action: #selector(self.dismissKeyboard))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.tintColor = UIColor.black
        textView.inputAccessoryView = toolBar
        textView.inputAccessoryView = toolBar
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
