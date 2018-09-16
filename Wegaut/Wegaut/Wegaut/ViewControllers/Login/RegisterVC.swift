//
//  RegisterVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/15/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var userImage: UIImage?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwNavigation: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgvwProfilePicture: UIImageView!
    @IBOutlet weak var btnChangePhoto: UIButton!
    @IBOutlet weak var svContainer: UIScrollView!
    @IBOutlet weak var vwContainer: UIView!
    
    @IBOutlet weak var vwUser: UIView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var tfUser: UITextField!
    
    @IBOutlet weak var vwLastName: UIView!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var tfLastName: UITextField!
    
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var vwBirthday: UIView!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var tfBirthday: UITextField!
    
    @IBOutlet weak var vwAbout: UIView!
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var txtvwComment: UITextView!
    @IBOutlet weak var lblCharCount: UILabel!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lblTitle.text = "REG_TIT".localized
        lblUser.text = "REG_USR".localized
        lblLastName.text = "REG_LN".localized
        lblEmail.text = "REG_EM".localized
        lblPassword.text = "REG_PSSWD".localized
        lblBirthday.text = "REG_BIRTH".localized
        lblAbout.text = "REG_ABOUT".localized
        txtvwComment.text = "REG_DESC".localized
        lblCharCount.text = "0/250"
        
        txtvwComment.cornerRadius(cornerRadius: 5)
        txtvwComment.layer.borderWidth = 1
        txtvwComment.layer.borderColor = UIColor.lightGray.cgColor
        txtvwComment.delegate = self
        
        tfUser.delegate = self
        tfLastName.delegate = self
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfBirthday.delegate = self
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    /// Used to get a selected image from the Photo Library
    func getImageFromPhotoLibrary() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker,
                     animated: true,
                     completion: nil)
    }
    
    /// Used to call camera view and get the taken image
    func getImageFromCamera() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.delegate = self
        self.present(imagePicker,
                     animated: true,
                     completion: nil)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actClose(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)       
    }
    
    @IBAction func actChangePhoto(_ sender: UIButton) {
        
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
    
    @IBAction func actRegister(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showInterests",
                          sender: nil)
    }
}

//MARK: - EXTENSIONS

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            userImage = selectedImage
            imgvwProfilePicture.image = userImage
            btnChangePhoto.setImage(UIImage(),
                                    for: UIControlState.normal)
            btnChangePhoto.backgroundColor = UIColor.clear
        }
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case tfUser:
            tfLastName.becomeFirstResponder()
            
        case tfLastName:
            tfEmail.becomeFirstResponder()
            
        case tfEmail:
            tfPassword.becomeFirstResponder()
            
        case tfPassword:
            tfBirthday.becomeFirstResponder()
            
        case tfBirthday:
            txtvwComment.becomeFirstResponder()
            
        default:
            dismissKeyboard()
        }
        return true
    }
}

extension RegisterVC: UITextViewDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.showInvalidInputStateWhen(isValidInput: false)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.size.width,
                                                        height: 44))
        let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                                            target: self,
                                                            action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "OK",
                                                         style: UIBarButtonItemStyle.done,
                                                         target: self,
                                                         action: #selector(self.dismissKeyboard))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.tintColor = UIColor.black
        textView.inputAccessoryView = toolBar
        if textView.text == "REG_DESC".localized {
            
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            
            textView.text = "REG_DESC".localized
        } else {
            
            textView.text = textView.text.trimmingCharacters(in: .whitespaces)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if (self.txtvwComment == textView) {
            
            if (range.location == 0 && text == " ") {
                
                return false
            }
            if (text.rangeOfCharacter(from: .newlines) == nil && (textView.text! + text).count <= 100) {
                
                self.lblCharCount.text = "\(self.txtvwComment.text.count + text.count) / 100"
                self.lblCharCount.textColor = UIColor.black
                return true
            } else {
                
                self.lblCharCount.textColor = UIColor.red
                return false
            }
        }
        return true
    }
}
