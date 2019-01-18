//
//  ProfileVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var userData: User!
    var userImage: UIImage?
    var arrMyEvents: [Event]!
    var arrGoingEvents: [Event]!
    var arrFavoriteEvents: [Event]!
    var arrSharedevents: [Event]!
    var currentSegmentControlIndex: Int!{
        didSet{
            cvEvents.reloadData()
        }
    }
    var selectedEvent: Event?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnProfilePic: UIButton!
    @IBOutlet weak var imgvwNewProfilePic: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserDescription: UILabel!
    @IBOutlet weak var vwUsage: UIView!
    @IBOutlet weak var lblFollowersQuantity: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblWegautLevel: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblNumberOfEvents: UILabel!
    @IBOutlet weak var lblEvents: UILabel!
    @IBOutlet weak var cvEvents: UICollectionView!
    
    @IBOutlet weak var imgvwSection1: UIImageView!
    @IBOutlet weak var lblSection1: UILabel!
    @IBOutlet weak var btnSection1: UIButton!
    @IBOutlet weak var vwDivider1: UIView!
    @IBOutlet weak var imgvwSection2: UIImageView!
    @IBOutlet weak var lblSection2: UILabel!
    @IBOutlet weak var btnSection2: UIButton!
    @IBOutlet weak var vwDivider2: UIView!
    @IBOutlet weak var imgvwSection3: UIImageView!
    @IBOutlet weak var lblSection3: UILabel!
    @IBOutlet weak var btnSection3: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        let bbiSettings: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ICMenu"),
                                                           style: UIBarButtonItem.Style.plain,
                                                           target: self,
                                                           action: #selector(self.showSettings))
        self.navigationItem.setRightBarButton(bbiSettings,
                                              animated: false)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        userData = User.getUserData()
        arrMyEvents = Event.getEvents()
        arrGoingEvents = Event.getEvents()
        arrFavoriteEvents = Event.getEvents()
        arrSharedevents = Event.getEvents()
        currentSegmentControlIndex = 0
        
        lblUsername.text = userData.usName
        btnProfilePic.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        if let anURL = URL(string: userData.usProfileImageURL){
            
            btnProfilePic.sd_setImage(with: anURL,
                                      for: UIControl.State.normal,
                                      completed: nil)
        }
        lblUserDescription.text = userData.usDescription
        lblFollowersQuantity.text = "\(userData.usFollowers.count)"
        lblFollowers.text = "PRO_FOLWRS".localized
        lblWegautLevel.text = userData.usWegautLevel.description
        lblLevel.text = "PRO_LEVEL".localized
        lblEvents.text = "PRO_EVENTS".localized
        lblNumberOfEvents.text = "\(arrMyEvents.count)"
        
        imgvwSection1.image = #imageLiteral(resourceName: "ICPurpleCalendar")
        lblSection1.text = "PRO_GOING".localized
        imgvwSection2.image = #imageLiteral(resourceName: "ICWhiteHearth")
        lblSection2.text = "PRO_FAVS".localized
        imgvwSection3.image = #imageLiteral(resourceName: "ICWhiteShare")
        lblSection3.text = "PRO_SHARED".localized
        
        btnProfilePic.cornerRadius(cornerRadius: nil)
        btnProfilePic.layer.borderWidth = 1
        btnProfilePic.layer.borderColor = UIColor.black.cgColor
        imgvwNewProfilePic.cornerRadius(cornerRadius: nil)
        imgvwNewProfilePic.layer.borderWidth = 0.5
        imgvwNewProfilePic.layer.borderColor = UIColor.black.cgColor
        self.addImageLogoToNavBar()
        vwUsage.cornerRadius(cornerRadius: 5)
        vwUsage.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowEventDetail"{
            
            let destinationVC: EventFeedDetailVC = segue.destination as! EventFeedDetailVC
            destinationVC.currentEvent = selectedEvent
        }
    }
    
    //MARK: - FUNCTIONS
    
    func setSegmentedControlUI(){
        
        switch currentSegmentControlIndex {
            
        case 0:
            lblSection1.textColor = UIColor.mediumPurple
            imgvwSection1.image = #imageLiteral(resourceName: "ICPurpleCalendar")
            lblSection2.textColor = UIColor.lightGray
            imgvwSection2.image = #imageLiteral(resourceName: "ICWhiteHearth")
            lblSection3.textColor = UIColor.lightGray
            imgvwSection3.image = #imageLiteral(resourceName: "ICWhiteShare")
            
        case 1:
            lblSection1.textColor = UIColor.lightGray
            imgvwSection1.image = #imageLiteral(resourceName: "ICDate")
            lblSection2.textColor = UIColor.mediumPurple
            imgvwSection2.image = #imageLiteral(resourceName: "ICHearth")
            lblSection3.textColor = UIColor.lightGray
            imgvwSection3.image = #imageLiteral(resourceName: "ICWhiteShare")
            
        case 2:
            lblSection1.textColor = UIColor.lightGray
            imgvwSection1.image = #imageLiteral(resourceName: "ICDate")
            lblSection2.textColor = UIColor.lightGray
            imgvwSection2.image = #imageLiteral(resourceName: "ICWhiteHearth")
            lblSection3.textColor = UIColor.mediumPurple
            imgvwSection3.image = #imageLiteral(resourceName: "ICPurpleShare")
            
        default:
            break
        }
    }
    
    @objc func showSettings(){
        
        self.performSegue(withIdentifier: "ShowSettings",
                          sender: self)
    }
    
    /// Used to get a selected image from the Photo Library
    func getImageFromPhotoLibrary(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker,
                     animated: true,
                     completion: nil)
    }
    
    /// Used to call camera view and get the taken image
    func getImageFromCamera(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.delegate = self
        self.present(imagePicker,
                     animated: true,
                     completion: nil)
    }
    
    //MARK: - ACTIONS

    @IBAction func actProfilePic(_ sender: UIButton) {
        
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
    
    @IBAction func actSelectSegmentIndex(_ sender: UIButton) {
        
        currentSegmentControlIndex = sender.tag
        setSegmentedControlUI()
    }
    
    @IBAction func actShowFollowers(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showFollowers",
                          sender: nil)
    }
    
    @IBAction func actShowMedals(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showMedals",
                          sender: nil)
    }
    
    @IBAction func actShowMyEvents(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showMyEvents",
                          sender: nil)
    }
}

//MARK: - EXTENSIONS

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate & UICollectionViewDelegateFlowLayout

extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch currentSegmentControlIndex {
            
        case 0:
            return arrGoingEvents.count
            
        case 1:
            return arrFavoriteEvents.count
            
        case 2:
            return arrSharedevents.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth:CGFloat = (cvEvents.frame.width - 40) / 3
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: EventCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCVCell
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let aCell: EventCVCell = cell as! EventCVCell
        switch currentSegmentControlIndex {
            
        case 0:
            aCell.currentEvent = arrGoingEvents[indexPath.row]
            
        case 1:
            aCell.currentEvent = arrFavoriteEvents[indexPath.row]
            
        case 2:
            aCell.currentEvent = arrSharedevents[indexPath.row]
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let aCell: EventCVCell = cvEvents.cellForItem(at: indexPath) as! EventCVCell
        guard let anEvent = aCell.currentEvent else{
            
            return
        }
        selectedEvent = anEvent
        self.performSegue(withIdentifier: "ShowEventDetail", sender: self)
    }
}

//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate

extension ProfileVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        if let selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            
            userImage = selectedImage
            btnProfilePic.setImage(userImage, for: UIControl.State.normal)
        }
        self.dismiss(animated: true, completion: nil)
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
