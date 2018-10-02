//
//  MultimediaInfoVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SafariServices

class MultimediaInfoVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrMultimedia: [Multimedia]!
    var currentEditingIndex: Int!
    var currentMultimediaTypeEditing: MultimediaType = MultimediaType.image
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvMultimedia: UITableView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrMultimedia = []
        tvMultimedia.reloadData()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    func showSelectPhotoAlert() {
        
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
    
    @objc func showURLPreview(aURL: String) {
        
        guard let url = URL(string: "http://" + aURL) else {
            return
        }
        openSafariVC(url: url)
    }
    
    func openSafariVC(url: URL) {
        
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    @objc func addImage() {
        
        currentMultimediaTypeEditing = MultimediaType.image
        arrMultimedia.insert(Multimedia.getDefaultMultimediaWith(type: currentMultimediaTypeEditing),
                             at: 0)
        tvMultimedia.reloadData()
    }
    
    @objc func addVideo() {
        
        currentMultimediaTypeEditing = MultimediaType.video
        arrMultimedia.insert(Multimedia.getDefaultMultimediaWith(type: currentMultimediaTypeEditing),
                             at: 0)
        tvMultimedia.reloadData()
    }
    
    @objc func addURL() {
        
        currentMultimediaTypeEditing = MultimediaType.url
        arrMultimedia.insert(Multimedia.getDefaultMultimediaWith(type: currentMultimediaTypeEditing),
                             at: 0)
        tvMultimedia.reloadData()
    }
    
    @objc func addCell() {
        
        tvMultimedia.reloadData()
    }
    
    @objc func finishEditing() {
        
        self.dismissKeyboard()
        tvMultimedia.reloadData()
    }
    
    //MARK: - ACTIONS

}

extension MultimediaInfoVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let buttonWidth: CGFloat = (screenSize.width - 70) / 3
        let aView: UIView = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: screenSize.width,
                                                 height: 70))
        aView.backgroundColor = UIColor.mediumPurple
        let btnAddImage: UIButton = UIButton(frame: CGRect(x: 5,
                                                           y: 5,
                                                           width: buttonWidth,
                                                           height: 60))
        btnAddImage.setImage(#imageLiteral(resourceName: "ICAddPicture"),
                             for: UIControl.State.normal)
        btnAddImage.contentMode = UIView.ContentMode.scaleAspectFit
        btnAddImage.addTarget(self,
                              action: #selector(self.addImage),
                              for: UIControl.Event.touchUpInside)
        aView.addSubview(btnAddImage)
        let btnAddVideo: UIButton = UIButton(frame: CGRect(x: buttonWidth + 35,
                                                         y: 5,
                                                         width: buttonWidth,
                                                         height: 60))
        btnAddVideo.setImage(#imageLiteral(resourceName: "ICAddVideo"),
                           for: UIControl.State.normal)
        btnAddVideo.contentMode = UIView.ContentMode.scaleAspectFit
        btnAddVideo.addTarget(self,
                            action: #selector(self.addVideo),
                            for: UIControl.Event.touchUpInside)
        aView.addSubview(btnAddVideo)
        let btnAddURL: UIButton = UIButton(frame: CGRect(x: (buttonWidth * 2) + 70,
                                                           y: 5,
                                                           width: buttonWidth,
                                                           height: 60))
        btnAddURL.setImage(#imageLiteral(resourceName: "ICAddURL"),
                             for: UIControl.State.normal)
        btnAddURL.contentMode = UIView.ContentMode.scaleAspectFit
        btnAddURL.addTarget(self,
                              action: #selector(self.addURL),
                              for: UIControl.Event.touchUpInside)
        aView.addSubview(btnAddURL)
        return aView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrMultimedia.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch arrMultimedia[indexPath.row].mulMediaType {
            
        case .url:
            let aCell: NewURLTVCell = tableView.dequeueReusableCell(withIdentifier: "NewURLCell",
                                                                    for: indexPath) as! NewURLTVCell
            aCell.actOpenURL = {
                (urlToOpen) in
                self.showURLPreview(aURL: urlToOpen)
            }
            return aCell
            
        case .image:
            let aCell: NewImageTVCell = tableView.dequeueReusableCell(withIdentifier: "NewImageCell",
                                                                      for: indexPath) as! NewImageTVCell
            aCell.actNewImage = {
                
                self.showSelectPhotoAlert()
            }
            return aCell
            
        case .video:
            let aCell: NewVideoTVCell = tableView.dequeueReusableCell(withIdentifier: "NewVideoCell",
                                                                      for: indexPath) as! NewVideoTVCell
            aCell.actNewVideo = {
                
                //TODO: SELECT VIDEO
            }
            return aCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch arrMultimedia[indexPath.row].mulMediaType {
            
        case .url:
            let aCell: NewURLTVCell = cell as! NewURLTVCell
            aCell.currentMultimedia = arrMultimedia[indexPath.row]
            
        case .image:
            let aCell: NewImageTVCell = cell as! NewImageTVCell
            aCell.currentMultimedia = arrMultimedia[indexPath.row]
            
        case .video:
            let aCell: NewVideoTVCell = cell as! NewVideoTVCell
            aCell.currentMultimedia = arrMultimedia[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return isEditing ? 50 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if isEditing {
            let screenSize: CGRect = UIScreen.main.bounds
            let buttonWidth: CGFloat = screenSize.width - 150
            let aView: UIView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: screenSize.width,
                                                     height: 50))
            aView.backgroundColor = UIColor.deepPurple
            let btnSaveCell: UIButton = UIButton(frame: CGRect(x: 50,
                                                               y: 5,
                                                               width: buttonWidth,
                                                               height: 40))
            btnSaveCell.addTarget(self,
                                  action: #selector(self.addCell),
                                  for: UIControl.Event.touchUpInside)
            btnSaveCell.setTitle("MMI_SAVE".localized,
                                 for: UIControl.State.normal)
            btnSaveCell.setTitleColor(UIColor.white,
                                      for: UIControl.State.normal)
            aView.addSubview(btnSaveCell)
            let btnDeleteCell: UIButton = UIButton(frame: CGRect(x: 100 + buttonWidth,
                                                               y: 5,
                                                               width: buttonWidth,
                                                               height: 40))
            btnDeleteCell.addTarget(self,
                                  action: #selector(self.finishEditing),
                                  for: UIControl.Event.touchUpInside)
            btnDeleteCell.setTitle("MMI_CANC".localized,
                                 for: UIControl.State.normal)
            btnDeleteCell.setTitleColor(UIColor.white,
                                      for: UIControl.State.normal)
            aView.addSubview(btnDeleteCell)
            return aView
        }
        return nil
    }
}

extension MultimediaInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            
            switch currentMultimediaTypeEditing {
                
            case .image:
                self.arrMultimedia[currentEditingIndex].mulLocalImage = selectedImage
                self.tvMultimedia.reloadData()
                
            case .video:
                break
                
            case .url:
                break
            }
        }
        self.dismiss(animated: true, completion: nil)
        tvMultimedia.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
}

extension MultimediaInfoVC: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        controller.dismiss(animated: true,
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
