//
//  SponsorshipInfoVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SafariServices

typealias TakePhotoAction = ()->Void

class SponsorshipInfoVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrOrganizers: [Organizer]!
    var arrSponsorships: [Sponsorship]!
    var isEditingOrganizer: Bool = false
    var currentEditingIndex: Int = 0
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tfEventURL: UITextField!
    @IBOutlet weak var tvOrganizers: UITableView!
    @IBOutlet weak var tvSponsorships: UITableView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrOrganizers = []
        arrSponsorships = []
        tfEventURL.placeholder = "SPO_EVURL".localized
        tfEventURL.delegate = self
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
    
    @objc func addNewOrganizer() {
        
        arrOrganizers.insert(Organizer.getDefaultOrganizer(),
                             at: 0)
        tvOrganizers.reloadData()
    }
    
    @objc func addNewSponsorship() {
        
        arrSponsorships.insert(Sponsorship.getDefaultSponsor(),
                               at: 0)
        tvSponsorships.reloadData()
    }
    
    //MARK: ACTIONS
    
    @IBAction func actShowPreview(_ sender: UIButton) {
        
        guard let url = URL(string: "http://" + tfEventURL.text!) else {
            return
        }
        openSafariVC(url: url)
    }
    
    func openSafariVC(url: URL) {
        
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
}

extension SponsorshipInfoVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let vwHeader: UIView = UIView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenSize.width,
                                                    height: 25))
        vwHeader.backgroundColor = UIColor.deepPurple
        let lblTitle: UILabel = UILabel(frame: CGRect(x: 16,
                                                      y: 2,
                                                      width: screenSize.width - 32,
                                                      height: 21))
        lblTitle.textColor = UIColor.white
        lblTitle.text = tableView == tvOrganizers ? "SPO_ORG".localized : "SPO_SPO".localized
        lblTitle.textAlignment = NSTextAlignment.center
        vwHeader.addSubview(lblTitle)
        return vwHeader
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableView == tvOrganizers ?  arrOrganizers.count : arrSponsorships.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tvSponsorships {
            
            let aCell: SponsorshipTVCell = tableView.dequeueReusableCell(withIdentifier: "SponsorCell",
                                                                         for: indexPath) as! SponsorshipTVCell
            aCell.currentSponsor = arrSponsorships[indexPath.row]
            aCell.actTakePhoto = {
                
                self.showSelectPhotoAlert()
                self.isEditingOrganizer = false
                self.currentEditingIndex = indexPath.row
            }
            return aCell
        } else {
            
            let aCell: OrganizerTVCell = tableView.dequeueReusableCell(withIdentifier: "OrganizerCell",
                                                                       for: indexPath) as! OrganizerTVCell
            aCell.currentOrganizer = arrOrganizers[indexPath.row]
            aCell.actTakePhoto = {
                
                self.showSelectPhotoAlert()
                self.isEditingOrganizer = true
                self.currentEditingIndex = indexPath.row
            }
            return aCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let vwFooter: UIView = UIView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenSize.width,
                                                    height: 25))
        vwFooter.backgroundColor = UIColor.white
        let btnNewRow: UIButton = UIButton(frame: CGRect(x: (screenSize.width / 2) - 20,
                                                      y: 5,
                                                      width: 40,
                                                      height: 40))
        btnNewRow.setImage(#imageLiteral(resourceName: "ICPlus"),
                           for: UIControlState.normal)
        btnNewRow.backgroundColor = UIColor.deepPurple
        btnNewRow.setTitle("",
                           for: UIControlState.normal)
        if tableView == tvOrganizers {
            
            btnNewRow.addTarget(self,
                                action: #selector(addNewOrganizer),
                                for: UIControlEvents.touchUpInside)
        } else {
            
            btnNewRow.addTarget(self,
                                action: #selector(addNewSponsorship),
                                for: UIControlEvents.touchUpInside)
        }
        btnNewRow.cornerRadius(cornerRadius: nil)
        vwFooter.addSubview(btnNewRow)
        return vwFooter
    }
}

extension SponsorshipInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            if isEditingOrganizer {
                
                arrOrganizers[currentEditingIndex].orgLocalImage = selectedImage
                tvOrganizers.reloadData()
            } else {
                arrSponsorships[currentEditingIndex].spoLocalImage = selectedImage
                tvSponsorships.reloadData()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
}

extension SponsorshipInfoVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text!.isAValidURL {
            
            textField.addRightImageWith(image: #imageLiteral(resourceName: "ICCheck"),
                                       tintColor: UIColor.deepPurple,
                                       paddingUpDown: 0,
                                       paddingLeftRight: 0)
        } else {
            
            textField.addRightImageWith(image: #imageLiteral(resourceName: "ICWarning"),
                                       tintColor: UIColor.red,
                                       paddingUpDown: 0,
                                       paddingLeftRight: 0)
        }
    }
}

extension SponsorshipInfoVC: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        controller.dismiss(animated: true,
                           completion: nil)
    }
}
