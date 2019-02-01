//
//  NewSponsorCVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 12/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

typealias newSponsorCellAddedAction = (Sponsorship)-> Void

class NewSponsorCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentSponsor: Sponsorship? {
        didSet{
            drawCell()
        }
    }
    var actNewSponsorCellAdded: newSponsorCellAddedAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnSponsorImage: UIButton!
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        guard let aSponsor = currentSponsor else { return }
        btnSponsorImage.setImage(aSponsor.spoLocalImage,
                                   for: UIControl.State.normal)
    }
    
    /// Used to get a selected image from the Photo Library
    func getImageFromPhotoLibrary() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.delegate = self
        self.parentViewController?.present(imagePicker,
                                           animated: true,
                                           completion: nil)
    }
    
    /// Used to call camera view and get the taken image
    func getImageFromCamera() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.delegate = self
        self.parentViewController?.present(imagePicker,
                                           animated: true,
                                           completion: nil)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actAddImage(_ sender: UIButton) {
        
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
        self.parentViewController?.present(alert,
                                           animated: true,
                                           completion: nil)
    }
    
}

extension NewSponsorCVCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            
            currentSponsor!.spoLocalImage = selectedImage
            btnSponsorImage.setImage(selectedImage,
                                       for: UIControl.State.normal)
        }
        self.parentViewController?.dismiss(animated: true,
                                           completion: {
                                            if  let anAction = self.actNewSponsorCellAdded,
                                                let aSponsor = self.currentSponsor {
                                                anAction(aSponsor)
                                            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.parentViewController?.dismiss(animated: true,
                                           completion: nil)
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
