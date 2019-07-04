//
//  ProfileVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseStorage
import KVNProgress

class ProfileVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var currentUser: User?
    var userImage: UIImage?
    var currentSegmentControlIndex: Int!{
        didSet{
            cvEvents.reloadData()
        }
    }
    var selectedEvent: Event?
    var isOtherUserProfile: Bool = false
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnProfilePic: UIButton!
    @IBOutlet weak var imgvwNewProfilePic: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserDescription: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var vwUsage: UIView!
    @IBOutlet weak var lblFollowersQuantity: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblWegautLevel: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblNumberOfEvents: UILabel!
    @IBOutlet weak var lblEvents: UILabel!
    @IBOutlet weak var cvEvents: UICollectionView!
    
    @IBOutlet weak var vwUserEvents: UIView!
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
        currentUser == nil ? loadUserData() : (isOtherUserProfile = true)
        btnProfilePic.cornerRadius(cornerRadius: nil)
        btnProfilePic.layer.borderWidth = 1
        btnProfilePic.layer.borderColor = UIColor.black.cgColor
        imgvwNewProfilePic.cornerRadius(cornerRadius: nil)
        imgvwNewProfilePic.layer.borderWidth = 0.5
        imgvwNewProfilePic.layer.borderColor = UIColor.black.cgColor
        self.addImageLogoToNavBar()
        vwUsage.cornerRadius(cornerRadius: 5)
        vwUsage.clipsToBounds = true
        imgvwNewProfilePic.isHidden = isOtherUserProfile
        vwUserEvents.isHidden = isOtherUserProfile
        currentSegmentControlIndex = 0
        lblUsername.text = ""
        lblUserDescription.text = ""
        
        if isOtherUserProfile {
            btnFollow.isHidden = false
            btnFollow.setTitle("PRO_FOLLOW".localized, for: UIControl.State.normal)
            btnFollow.cornerRadius(cornerRadius: 5)
            btnReport.isHidden = false
            btnReport.setTitle("PRO_REPORT".localized, for: UIControl.State.normal)
            btnReport.cornerRadius(cornerRadius: 5)
        }
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
    
    func updateUI() {
        lblUsername.text = currentUser?.usName ?? ""
        btnProfilePic.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btnProfilePic.setImage(self.currentUser?.usProfileImage, for: UIControl.State.normal)
        lblUserDescription.text = currentUser?.usDescription ?? ""
        lblFollowersQuantity.text = "\(currentUser?.usFollowers.count ?? 0)"
        lblFollowers.text = "PRO_FOLWRS".localized
        lblWegautLevel.text = currentUser?.usWegautLevel.description ?? ""
        lblLevel.text = "PRO_LEVEL".localized
        lblEvents.text = "PRO_EVENTS".localized
        lblNumberOfEvents.text = "\(currentUser?.usCreatedEvents.count ?? 0)"
        
        imgvwSection1.image = #imageLiteral(resourceName: "ICPurpleCalendar")
        lblSection1.text = "PRO_GOING".localized
        imgvwSection2.image = #imageLiteral(resourceName: "ICWhiteHearth")
        lblSection2.text = "PRO_FAVS".localized
        imgvwSection3.image = #imageLiteral(resourceName: "ICWhiteShare")
        lblSection3.text = "PRO_SHARED".localized
    }
    
    func loadUserData() {
        
        KVNProgress.show(withStatus: "PRO_DOWN".localized)
        if let aUserId = UserDefaults.standard.string(forKey: WegautConstants.USER_ID) {
            let ref  = Database.database().reference()
            ref.child("users").child(aUserId).observeSingleEvent(of: DataEventType.value) { (userInfo) in
                if let aDic = userInfo.value as? [String: Any], let aUser = User.convertDicToUser(aDic) {
                    self.currentUser = aUser
                    self.getUserProfilePhoto(userId: aUserId)
                } else {
                    self.logOut()
                }
            }
        } else {
            logOut()
        }
    }
    
    func getUserProfilePhoto(userId: String) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child(WegautConstants.PROFILE_IMAGES_SOURCE+"\(userId)")
        imagesRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let imageData = data {
                self.currentUser?.usProfileImage = UIImage(data: imageData) ?? #imageLiteral(resourceName: "BGLogo")
                self.updateUI()
                KVNProgress.dismiss()
                self.cvEvents.isHidden = false
                self.cvEvents.reloadData()
            } else {
                KVNProgress.showError(withStatus: "PRO_IMG_ERR".localized)
            }
        }
    }
    
    func logOut() {
        KVNProgress.dismiss()
        let alert = UIAlertController(title: "PRO_ERR_TIT".localized, message: "PRO_ERR_MESS".localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.destructive, handler: { (alert) in
            UserDefaults.standard.set(false, forKey: WegautConstants.IS_USER_LOGGED)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Login",
                                                        bundle: nil)
            let loginRoot = storyBoard.instantiateViewController(withIdentifier: "RootLogin") as! UINavigationController
            self.present(loginRoot, animated:true, completion:nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
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
    
    func getNumberOfItemsFor(section: Int)-> (Int, Bool) {
        
        switch section {
        case 0:
            guard let assistingEvents = self.currentUser?.usAssistingEvents.count else { return (1,true) }
            return assistingEvents == 0 ? (1, true) : (assistingEvents, false)
        case 1:
            guard let favouritedEvents = self.currentUser?.usFavouriteEvents.count else { return (1, true) }
            return favouritedEvents == 0 ? (1, true) : (favouritedEvents, false)
        case 2:
            guard let sharedEvents = self.currentUser?.usSharedEvents.count else { return (1, true) }
            return sharedEvents == 0 ? (1, true) : (sharedEvents, false)
        default: return (0, false)
        }
    }
    
    //MARK: - ACTIONS

    @IBAction func actProfilePic(_ sender: UIButton) {
        
        if !isOtherUserProfile {
            
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
    
    @IBAction func actBtnFollow(_ sender: UIButton) {
        
    }
    
    @IBAction func actBtnReport(_ sender: UIButton) {
    }
}

//MARK: - EXTENSIONS

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate & UICollectionViewDelegateFlowLayout

extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return getNumberOfItemsFor(section: section).0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight: CGFloat = getNumberOfItemsFor(section: currentSegmentControlIndex).1 ? 300 : ((cvEvents.frame.width - 40) / 3)
        let cellWidth: CGFloat = getNumberOfItemsFor(section: currentSegmentControlIndex).1 ? (cvEvents.frame.width - 40) : ((cvEvents.frame.width - 40) / 3)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if getNumberOfItemsFor(section: indexPath.section).1 {
            let aCell: EmptyEventCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyEventCell", for: indexPath) as! EmptyEventCVCell
            aCell.delegate = self
            aCell.setUpCellFor(section: currentSegmentControlIndex)
            return aCell
        } else {
            let aCell: EventCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCVCell
            return aCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !getNumberOfItemsFor(section: indexPath.section).1 {
            let aCell: EventCVCell = cell as! EventCVCell
            switch currentSegmentControlIndex {
            case 0:
                guard let anEvent = currentUser?.usAssistingEvents[indexPath.row] else { return }
                aCell.currentEvent = anEvent
            case 1:
                guard let anEvent = currentUser?.usFavouriteEvents[indexPath.row] else { return }
                aCell.currentEvent = anEvent
            case 2:
                guard let anEvent = currentUser?.usSharedEvents[indexPath.row] else { return }
                aCell.currentEvent = anEvent
            default:
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !getNumberOfItemsFor(section: indexPath.section).1 {
            let aCell: EventCVCell = cvEvents.cellForItem(at: indexPath) as! EventCVCell
            guard let anEvent = aCell.currentEvent else { return }
            selectedEvent = anEvent
            self.performSegue(withIdentifier: "ShowEventDetail", sender: self)
        }
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

extension ProfileVC: EmptyEventCVCellProtocol {
    
    func didTappedGoToFeed() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootNavigation: UITabBarController = storyBoard.instantiateViewController(withIdentifier: "RootNavigation") as! UITabBarController
        self.present(rootNavigation, animated: true, completion: nil)
    }
}
