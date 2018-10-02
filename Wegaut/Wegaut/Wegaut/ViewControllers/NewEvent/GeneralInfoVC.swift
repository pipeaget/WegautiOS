//
//  GeneralInfoVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class GeneralInfoVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrNewEventTags: [(Tag, Bool)]!
    var arrSelectedTags: [Tag]!
    var eventImage: UIImage?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnEventImage: UIButton!
    @IBOutlet weak var tfEventName: UITextField!
    @IBOutlet weak var tfEventAssitanceType: UITextField!
    @IBOutlet weak var txtvwEventDescription: UITextView!
    @IBOutlet weak var lblDescriptionCount: UILabel!
    @IBOutlet weak var cvEventTags: UICollectionView!
    
    //MARK: - VIEW LIFECYLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrNewEventTags = Tag.getTagsForNewEvent()
        arrSelectedTags = []
        tfEventName.placeholder = "GIE_ENAME".localized
        tfEventAssitanceType.placeholder = "GIE_ASTY".localized
        txtvwEventDescription.text = "GIE_DESC".localized
        lblDescriptionCount.text = "0/250"
        btnEventImage.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        txtvwEventDescription.layer.borderColor = UIColor.black.cgColor
        txtvwEventDescription.layer.borderWidth = 1
        txtvwEventDescription.cornerRadius(cornerRadius: 5)
        txtvwEventDescription.delegate = self
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
    
    func addTagWithIndex(aTag: Tag) {
        
        arrSelectedTags.append(aTag)
    }
    
    func removeTagWithIndex(aTag: Tag) {
        
        arrSelectedTags = arrSelectedTags.filter{$0.tagName != aTag.tagName}
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnEventImage(_ sender: UIButton) {
        
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

extension GeneralInfoVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrNewEventTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: TagCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell",
                                                                  for: indexPath) as! TagCVCell
        aCell.currentTag = arrNewEventTags[indexPath.row]
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        arrNewEventTags[indexPath.row].1 = !arrNewEventTags[indexPath.row].1
        arrNewEventTags[indexPath.row].1 ? addTagWithIndex(aTag: arrNewEventTags[indexPath.row].0) : removeTagWithIndex(aTag: arrNewEventTags[indexPath.row].0)
        cvEventTags.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 20) / 3,
                      height: 40)
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension GeneralInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            
            eventImage = selectedImage
            btnEventImage.setImage(eventImage,
                                           for: UIControl.State.normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
}

//MARK: - UITEXTVIEWDELEGATE

extension GeneralInfoVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.size.width,
                                                        height: 44))
        let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                                            target: self,
                                                            action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "OK".localized,
                                                         style: UIBarButtonItem.Style.done,
                                                         target: self,
                                                         action: #selector(self.dismissKeyboard))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.tintColor = UIColor.black
        textView.inputAccessoryView = toolBar
        if textView.text == "GIE_DESC".localized{
            
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == ""{
            
            textView.text = "GIE_DESC".localized
        }else{
            
            textView.text = textView.text.trimmingCharacters(in: .whitespaces)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(self.txtvwEventDescription == textView){
            
            if (range.location == 0 && text == " "){
                
                return false
            }
            if (text.rangeOfCharacter(from: .newlines) == nil && (textView.text! + text).count <= 250){
                
                self.lblDescriptionCount.text = "\(self.txtvwEventDescription.text.count + text.count) / 250"
                self.lblDescriptionCount.textColor = UIColor.black
                return true
            }else{
                
                self.lblDescriptionCount.textColor = UIColor.red
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
