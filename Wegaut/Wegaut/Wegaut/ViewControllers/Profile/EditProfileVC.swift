//
//  EditProfileVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {

    //MARK: - VARIABLES
    
    weak var activeField: UITextField?
    var userImage: UIImage?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnEditProfilePicture: UIButton!
    @IBOutlet weak var imgvwNewProfilePicture: UIImageView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfFatherLastName: UITextField!
    @IBOutlet weak var tfMotherLastName: UITextField!
    @IBOutlet weak var txtvwDescription: UITextView!
    @IBOutlet weak var lblCharacterCount: UILabel!
    @IBOutlet weak var btnUpdate: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        txtvwDescription.delegate = self
        for subview in self.view.subviews{
            
            if let aView = subview as? UITextField{
                
                aView.delegate = self
            }
        }
        let tgrDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                                action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tgrDismissKeyboard)
        btnEditProfilePicture.setImage(#imageLiteral(resourceName: "BGLogo"), for: UIControlState.normal)
        tfEmail.placeholder = "REG_MAIL".localized
        tfPassword.placeholder = "REG_PSSWD".localized
        tfConfirmPassword.placeholder = "REG_CONPSSWD".localized
        tfUsername.placeholder = "REG_USR_NAME".localized
        tfFatherLastName.placeholder = "REG_FAT_NAME".localized
        tfMotherLastName.placeholder = "REG_MOT_NAME".localized
        txtvwDescription.text = "REG_USR_BIO".localized
        btnUpdate.setTitle("EPC_UPD".localized, for: UIControlState.normal)
        
        btnEditProfilePicture.cornerRadius(cornerRadius: nil)
        btnEditProfilePicture.clipsToBounds = true
        btnEditProfilePicture.contentMode = UIViewContentMode.scaleAspectFill
        btnEditProfilePicture.layer.borderWidth = 1
        btnEditProfilePicture.layer.borderColor = UIColor.black.cgColor
        imgvwNewProfilePicture.cornerRadius(cornerRadius: nil)
        imgvwNewProfilePicture.layer.borderWidth = 0.5
        imgvwNewProfilePicture.layer.borderColor = UIColor.black.cgColor
        txtvwDescription.cornerRadius(cornerRadius: 5)
        txtvwDescription.layer.borderWidth = 1
        txtvwDescription.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    /// Used to get a selected image from the Photo Library
    func getImageFromPhotoLibrary(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker,
                     animated: true,
                     completion: nil)
    }
    
    /// Used to call camera view and get the taken image
    func getImageFromCamera(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.delegate = self
        self.present(imagePicker,
                     animated: true,
                     completion: nil)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actChangeProfilePicture(_ sender: UIButton) {
        
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
    
    @IBAction func actDismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    @IBAction func actUpdateUserData(_ sender: UIButton) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
}

//MARK: - EXTENSIONS

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension EditProfileVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            userImage = selectedImage
            btnEditProfilePicture.setImage(userImage,
                                           for: UIControlState.normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
}

//MARK: - UITextFieldDelegate

extension EditProfileVC: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeField = textField
        textField.showInvalidInputStateWhen(isValidInput: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case tfEmail:
            tfPassword.becomeFirstResponder()
            
        case tfPassword:
            tfConfirmPassword.becomeFirstResponder()
            
        case tfConfirmPassword:
            tfUsername.becomeFirstResponder()
            
        case tfUsername:
            tfFatherLastName.becomeFirstResponder()
            
        case tfFatherLastName:
            tfMotherLastName.becomeFirstResponder()
            
        case tfMotherLastName:
            txtvwDescription.becomeFirstResponder()
            
        case txtvwDescription:
            dismissKeyboard()
            
        default:
            break
        }
        return true
    }
}

//MARK: - UITEXTVIEWDELEGATE

extension EditProfileVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.size.width,
                                                        height: 44))
        let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                                            target: self,
                                                            action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "OK".localized,
                                                         style: UIBarButtonItemStyle.done,
                                                         target: self,
                                                         action: #selector(self.dismissKeyboard))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.tintColor = UIColor.black
        textView.inputAccessoryView = toolBar
        if textView.text == "REG_USR_BIO".localized{
            
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == ""{
            
            textView.text = "REG_USR_BIO".localized
        }else{
            
            textView.text = textView.text.trimmingCharacters(in: .whitespaces)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(self.txtvwDescription == textView){
            
            if (range.location == 0 && text == " "){
                
                return false
            }
            if (text.rangeOfCharacter(from: .newlines) == nil && (textView.text! + text).count <= 100){
                
                self.lblCharacterCount.text = "\(self.txtvwDescription.text.count + text.count) / 100"
                self.lblCharacterCount.textColor = UIColor.black
                return true
            }else{
                
                self.lblCharacterCount.textColor = UIColor.red
                return false
            }
        }
        return true
    }
}
