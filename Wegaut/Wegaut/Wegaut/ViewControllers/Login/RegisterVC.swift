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
import FirebaseDatabase
import FirebaseStorage
import KVNProgress

class RegisterVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrTextfields: [UITextField]!
    var keyBoardHeight: CGFloat = 0
    var currentUser: User!
    var tfError: UITextField!
    var dbRef: DatabaseReference!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwNavigation: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var tvRegister: UITableView!
    @IBOutlet weak var cnTvRegisterBottom: NSLayoutConstraint!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrTextfields = []
        currentUser = User.newUser()
        lblTitle.text = "REG_TIT".localized
        dbRef = Database.database().reference()
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
        DispatchQueue.main.async {
            self.cnTvRegisterBottom.constant = keyboardSize.height + 1
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async {
            self.cnTvRegisterBottom.constant = 0
        }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
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
    
    func changePhoto() {
        
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
        let editAction = UIAlertAction(title: "REG_EDIT".localized,
                                       style: UIAlertAction.Style.default) { (alertAction) -> Void in
                                        self.presentCropViewController(anImage: self.currentUser.usProfileImage)
        }
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    func scrollToMakeVisibleCellIn(section: Int) {
        tvRegister.scrollToRow(at: IndexPath(row: 0, section: section), at: UITableView.ScrollPosition.top, animated: true)
    }
    
    func showDateAlert() {
        let popupAlert: FORPopUpView = FORPopUpView(with: FORAlertData(datePicker: UIColor.white, aTitle: "", aMessage: "REG_PABIRTH".localized, yesButtonTitle: "OK".localized, yesButtonColor: UIColor.deepPurple, noButtonTitle: "CANCEL".localized, noButtonColor: UIColor.red))
        popupAlert.show(animated: true)
        popupAlert.dateSelection = { aDate in
            self.currentUser.usBirthdate = aDate.dateToStringEddMMMyyyy()
            self.tvRegister.reloadData()
            popupAlert.dismiss(animated: true)
            guard let aCell = self.tvRegister.cellForRow(at: IndexPath(row: 0, section: 5)) as? PasswordTVCell else { return }
            aCell.tfPassword.becomeFirstResponder()
            self.scrollToMakeVisibleCellIn(section: 5)
        }
        popupAlert.yesNoSuccess = { aBool in
            popupAlert.dismiss(animated: true)
        }
    }
    
    func showRegisterErrorAlert()-> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: "ERROR".localized, message: "REG_ERR".localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (alert) in
            UserDefaults.standard.set(nil, forKey: WegautConstants.USER_DATA)
        }))
        return alert
    }
    
    func showProfileUploadErrorAlert()-> UIAlertController {
        let alert:UIAlertController = UIAlertController(title: "ERROR".localized, message: "REG_PROF_ERR".localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    func uploadUserData() {
        
        UserDefaults.standard.set(User.convertUserToDic(self.currentUser), forKey: WegautConstants.USER_DATA)
        if let aUserData = UserDefaults.standard.object(forKey: WegautConstants.USER_DATA) as? [String: Any],
           let _ = User.convertDicToUser(aUserData) {
            
            Auth.auth().createUser(withEmail: currentUser.usEmail, password: currentUser.usPassword) { (authResult, error) in
                
                if let _ = error {
                    KVNProgress.dismiss()
                    self.present(self.showRegisterErrorAlert(), animated: true, completion: nil)
                } else {
                    if let anUser = authResult?.user {
                        self.dbRef.child("users").child(anUser.uid).setValue(["usId": anUser.uid,
                                                                              "usName": self.currentUser.usName,
                                                                              "usEmail": self.currentUser.usEmail,
                                                                              "usFirstName": self.currentUser.usFirstName,
                                                                              "usLastNames": self.currentUser.usLastNames,
                                                                              "usProfileImageURL": self.currentUser.usProfileImageURL,
                                                                              "usBirthdate": self.currentUser.usBirthdate,
                                                                              "usPassword": self.currentUser.usPassword,
                                                                              "usDescription": self.currentUser.usDescription,
                                                                              "usWegautLevel": self.currentUser.usWegautLevel.description,
                                                                              "usFollowers": self.currentUser.usFollowers,
                                                                              "usFollowing": self.currentUser.usFollowing,
                                                                              "usCreatedEvents": self.currentUser.usCreatedEvents,
                                                                              "usAssistingEvents": self.currentUser.usAssistingEvents,
                                                                              "usFavouriteEvents": self.currentUser.usFavouriteEvents,
                                                                              "usSharedEvents": self.currentUser.usSharedEvents,
                                                                              "usActivities": self.currentUser.usActivities,
                                                                              "usTags": self.currentUser.usTags])
                        UserDefaults.standard.set("\(anUser.uid)", forKey: WegautConstants.USER_ID)
                        self.currentUser.usId = anUser.uid
                        UserDefaults.standard.set(User.convertUserToDic(self.currentUser), forKey: WegautConstants.USER_DATA)
                        self.uploadProfileImage(userId: self.currentUser.usId)
                    }
                }
            }
        } else {
            KVNProgress.dismiss()
            self.present(self.showRegisterErrorAlert(), animated: true, completion: nil)
        }
    }
    
    func uploadProfileImage(userId: String) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child(WegautConstants.PROFILE_IMAGES_SOURCE+"\(userId)")
        if let anImageData = currentUser.usProfileImage.resize(targetSize: CGSize(width: 250, height: 250)).pngData() {
            imagesRef.putData(anImageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    KVNProgress.dismiss()
                    self.present(self.showProfileUploadErrorAlert(), animated: true, completion: nil)
                    return
                }else{
                    KVNProgress.dismiss()
                    dump(metadata!)
                    let alert: UIAlertController = UIAlertController(title: "REG_WELCOME".localized,
                                                                     message: "REG_HELLO".localized + " \(self.currentUser.usName)",
                        preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK",
                                                  style: UIAlertAction.Style.default, handler: { (alert) in
                                                    UserDefaults.standard.set(true,forKey: WegautConstants.IS_USER_LOGGED)
                                                    self.performSegue(withIdentifier: "showInterests", sender: nil)
                                                    
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            KVNProgress.dismiss()
            self.present(self.showProfileUploadErrorAlert(), animated: true, completion: nil)
        }
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)       
    }
    
    @objc func actRegister(_ sender: UIButton) {

        KVNProgress.show(withStatus: "REG_PROC".localized)
        var strErrorMessage: String = ""
        if currentUser.usName.isEmpty{
            
            strErrorMessage = "REG_INVUSNAME".localized
            tfError = arrTextfields[0]
        } else if currentUser.usName.isEmpty {

          strErrorMessage = "REG_INVNAME".localized
          tfError = arrTextfields[1]
        } else if currentUser.usLastNames.isEmpty {
            
            strErrorMessage = "REG_INVLANAME".localized
            tfError = arrTextfields[2]
        } else if !currentUser.usEmail.isAValidEmail {
            
            strErrorMessage = "REG_INVMAIL".localized
            tfError = arrTextfields[3]
        } else if currentUser.usBirthdate.isEmpty {
            
            strErrorMessage = "REG_INVBIRTH".localized
            tfError = arrTextfields[4]
        } else if currentUser.usPassword.isAValidPassword {
            
            strErrorMessage = "REG_INVPASS".localized
            tfError = arrTextfields[5]
        }
        if strErrorMessage != "" {
            
            KVNProgress.dismiss()
            let alertVC: UIAlertController = UIAlertController(title: "ERROR",
                                                               message: strErrorMessage,
                                                               preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "OK",
                                            style: UIAlertAction.Style.destructive,
                                            handler: nil))
            self.present(alertVC,
                         animated: true) {
                            if let _ = self.tfError {
                                
                                self.tfError?.showInvalidInputStateWhen(isValidInput: true)
                            }
            }
        } else {
            self.uploadUserData()
        }
    }
}

//MARK: - EXTENSIONS

extension RegisterVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:  return 180
        case 7:  return 150
        default: return 62
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            let aCell: UserProfileImageTVCell = tableView.dequeueReusableCell(withIdentifier: "UserProfileImageCell", for: indexPath) as! UserProfileImageTVCell
            aCell.currentImage = currentUser.usProfileImage
            aCell.delegate = self
            return aCell

        case 1:
            let aCell: UsernameTVCell = tableView.dequeueReusableCell(withIdentifier: "UsernameCell", for: indexPath) as! UsernameTVCell
            aCell.currentName = currentUser.usName
            aCell.delegate = self
            arrTextfields.contains(aCell.tfUsername) ? nil : arrTextfields.append(aCell.tfUsername)
            return aCell
            
        case 2:
            let aCell: FirstNameTVCell = tableView.dequeueReusableCell(withIdentifier: "FirstNameCell", for: indexPath) as! FirstNameTVCell
            aCell.currentFirstName = currentUser.usFirstName
            aCell.delegate = self
            arrTextfields.contains(aCell.tfFirstName) ? nil : arrTextfields.append(aCell.tfFirstName)
            return aCell
            
        case 3:
            let aCell: LastNamesTVCell = tableView.dequeueReusableCell(withIdentifier: "LastNamesCell", for: indexPath) as! LastNamesTVCell
            aCell.currentLastNames = currentUser.usLastNames
            arrTextfields.contains(aCell.tfLastNames) ? nil : arrTextfields.append(aCell.tfLastNames)
            aCell.delegate = self
            return aCell
            
        case 4:
            let aCell: EmailTVCell = tableView.dequeueReusableCell(withIdentifier: "EmailCell", for: indexPath) as! EmailTVCell
            aCell.currentEmail = currentUser.usEmail
            arrTextfields.contains(aCell.tfEmail) ? nil : arrTextfields.append(aCell.tfEmail)
            aCell.delegate = self
            return aCell
            
        case 5:
            let aCell: BirthdayTVCell = tableView.dequeueReusableCell(withIdentifier: "BirthdayCell", for: indexPath) as! BirthdayTVCell
            aCell.currentBirthday = currentUser.usBirthdate.description
            arrTextfields.contains(aCell.tfBirthday) ? nil : arrTextfields.append(aCell.tfBirthday)
            aCell.delegate = self
            return aCell
            
        case 6:
            let aCell: PasswordTVCell = tableView.dequeueReusableCell(withIdentifier: "PasswordCell", for: indexPath) as! PasswordTVCell
            aCell.currentPassword = currentUser.usPassword
            arrTextfields.contains(aCell.tfPassword) ? nil : arrTextfields.append(aCell.tfPassword)
            aCell.delegate = self
            return aCell
            
        default:
            let aCell: AboutTVCell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! AboutTVCell
            aCell.currentAbout = currentUser.usDescription
            aCell.delegate = self
            return aCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scrollToMakeVisibleCellIn(section: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let btnRegister: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        btnRegister.backgroundColor = UIColor.deepPurple
        btnRegister.setImage(#imageLiteral(resourceName: "ICDone"), for: UIControl.State.normal)
        btnRegister.addTarget(self, action: #selector(actRegister(_:)), for: UIControl.Event.touchUpInside)
        return section == 7 ? btnRegister : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 7 ? 50 : 0
    }
}

extension RegisterVC: UserProfileImageTVCellDelegate {
    
    func photoButtonPressed() {
        changePhoto()
    }
}

extension RegisterVC: UsernameTVCellDelegate {
    
    func textfieldUsernameEndEditing(text: String) {
        currentUser.usName = text
    }
    
    func usernameReturnPressed() {
        guard let aCell = tvRegister.cellForRow(at: IndexPath(row: 0, section: 2)) as? FirstNameTVCell else { return }
        aCell.tfFirstName.becomeFirstResponder()
        scrollToMakeVisibleCellIn(section: 2)
    }
}

extension RegisterVC: FirstNameTVCellDelegate {
    
    func textfieldFirstNameEndEditing(text: String) {
        currentUser.usName = text
    }
    
    func firstNameReturnPressed() {
        guard let aCell = tvRegister.cellForRow(at: IndexPath(row: 0, section: 3)) as? LastNamesTVCell else { return }
        aCell.tfLastNames.becomeFirstResponder()
        scrollToMakeVisibleCellIn(section: 3)
    }
}

extension RegisterVC: LastNamesTVCellDelegate {
    
    func textfieldLastNameEndEditing(text: String) {
        currentUser.usLastNames = text
    }
    
    func lastNamesReturnPressed() {
        guard let aCell = tvRegister.cellForRow(at: IndexPath(row: 0, section: 4)) as? EmailTVCell else { return }
        aCell.tfEmail.becomeFirstResponder()
        scrollToMakeVisibleCellIn(section: 4)
    }
}

extension RegisterVC: EmailTVCellDelegate {
    
    func textfieldEmailEndEditing(text: String) {
        currentUser.usEmail = text
    }
    
    func emailReturnPressed() {
        dismissKeyboard()
        guard let aCell = tvRegister.cellForRow(at: IndexPath(row: 0, section: 5)) as? BirthdayTVCell else { return }
        aCell.tfBirthday.becomeFirstResponder()
        scrollToMakeVisibleCellIn(section: 5)
    }
}

extension RegisterVC: BirthdayTVCellDelegate {
    
    func textfieldBirthdayPressed() {
        self.dismissKeyboard()
        showDateAlert()
    }
    
    func textfieldBirthdayEndEditing(text: String) {
        currentUser.usBirthdate = text
    }
    
    func birthdayReturnPressed() {
        guard let aCell = tvRegister.cellForRow(at: IndexPath(row: 0, section: 6)) as? PasswordTVCell else { return }
        aCell.tfPassword.becomeFirstResponder()
        scrollToMakeVisibleCellIn(section: 6)
    }
}

extension RegisterVC: PasswordTVCellDelegate {
    
    func passwordReturnPressed() {
        guard let aCell: AboutTVCell = tvRegister.cellForRow(at: IndexPath(row: 0, section: 7)) as? AboutTVCell else { return }
        aCell.txtvwAbout.becomeFirstResponder()
        scrollToMakeVisibleCellIn(section: 7)
    }
}

extension RegisterVC: AboutTVCellDelegate {
    
    func textfieldAboutEndEditing(text: String) {
        currentUser.usDescription = text
    }
    
    func aboutReturnPressed() {
        guard let aCell: AboutTVCell = tvRegister.cellForRow(at: IndexPath(row: 0, section: 8)) as? AboutTVCell else { return }
        aCell.dismissKeyboard()
    }
}

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            
            currentUser.usProfileImage = selectedImage
            tvRegister.reloadData()
        }
        self.dismiss(animated: true) {
            self.presentCropViewController(anImage: self.currentUser.usProfileImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
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
        
        currentUser.usProfileImage = image
        tvRegister.reloadData()
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
