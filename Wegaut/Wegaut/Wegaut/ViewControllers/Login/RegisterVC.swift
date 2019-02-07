//
//  RegisterVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/15/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit
import CropViewController
import FirebaseAuth

class RegisterVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var activeField: UITextField?
    var keyBoardHeight: CGFloat = 0
    var userImage: UIImage?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwNavigation: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
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
        
        btnChangePhoto.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btnChangePhoto.clipsToBounds = true
        btnChangePhoto.imageView?.backgroundColor = UIColor.lightPurple
        btnChangePhoto.backgroundColor = UIColor.lightPurple
        
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

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
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
        
        self.svContainer.scrollRectToVisible(btnRegister.frame,
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
    
    func presentCropViewController(anImage: UIImage) {
        
        let cropVC: CropViewController = CropViewController(croppingStyle: CropViewCroppingStyle.circular,
                                                            image: anImage)
        cropVC.delegate = self
        self.present(cropVC,
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
        if let anImage = userImage {
            
            let editAction = UIAlertAction(title: "REG_EDIT".localized,
                                           style: UIAlertAction.Style.default) { (alertAction) -> Void in
                                            self.presentCropViewController(anImage: anImage)
            }
            alert.addAction(editAction)
        }
        alert.addAction(cancelAction)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    @IBAction func actRegister(_ sender: UIButton) {
        
        UserDefaults.standard.set(true,
                                  forKey: WegautConstants.IS_USER_LOGGED)
        self.performSegue(withIdentifier: "showInterests",
                          sender: nil)
        
        /*if tfEmail.text!.isAValidEmail && tfPassword.text!.count > 6 {
            
            Auth.auth().createUser(withEmail: tfEmail.text!,
                                   password: tfPassword.text!) { (authResult, error) in
                                    
                                    if let anError = error {
                                        
                                        print(anError.localizedDescription)
                                    } else {
                                        
                                        print("Welcome \(authResult!.user.email)!!!")
                                        
                                    }
            }
            
        } else {
            
            //HANDLE INPUT DATA
        }*/
    }
}

//MARK: - EXTENSIONS

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            
            userImage = selectedImage
            btnChangePhoto.setImage(userImage,
                                    for: UIControl.State.normal)
        }
        self.dismiss(animated: true) {
            guard let anImage = self.userImage else  { return }
            self.presentCropViewController(anImage: anImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeField = textField
        textField.showInvalidInputStateWhen(isValidInput: false)
    }
    
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}

extension RegisterVC: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
        userImage = image
        btnChangePhoto.setImage(image,
                                for: UIControl.State.normal)
        cropViewController.dismiss(animated: true,
                                   completion: nil)
    }
}
