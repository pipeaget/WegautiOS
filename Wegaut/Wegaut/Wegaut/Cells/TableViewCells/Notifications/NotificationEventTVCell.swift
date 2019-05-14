//
//  NotificationEventTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

typealias showNotificationEventAction = ()-> Void

class NotificationEventTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentNotification: Activity? {
        didSet{
            drawCell()
        }
    }
    var actShowNotificationEvent: showNotificationEventAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgvwProfilePic: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblTimeLapse: UILabel!
    @IBOutlet weak var btnNotificationAction: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS

    func drawCell(){
        
        guard let aNotification = currentNotification,
              let anUser = aNotification.actUser else {
            return
        }
        vwContainer.cornerRadius(cornerRadius: 10)
        imgvwProfilePic.cornerRadius(cornerRadius: nil)
        if let anURL = URL(string: anUser.usProfileImageURL){
            
            imgvwProfilePic.sd_setImage(with: anURL,
                                        placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                        options: SDWebImageOptions.highPriority,
                                        completed: nil)
        } else {
            
            imgvwProfilePic.image = #imageLiteral(resourceName: "BGLogo")
        }
        btnNotificationAction.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btnNotificationAction.imageView?.image = getImageForNotificationType()
        lblUser.text = User.getUserCompleteName(user: anUser)
        lblNotification.text = aNotification.actTitle
        lblTimeLapse.text = "\(aNotification.actDate)"
    }
    
    func getImageForNotificationType()-> UIImage {
        
        guard let aNotification = currentNotification else  { return #imageLiteral(resourceName: "LGNavBar")}
        switch aNotification.actType {
            
        case ActivityType.newEvent: return #imageLiteral(resourceName: "ICDatePurple")
        default:                    return #imageLiteral(resourceName: "LGNavBar")
        }
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnNotificationAction(_ sender: UIButton) {
        
        if let anAction = self.actShowNotificationEvent {
            
            anAction()
        }
    }
    
}
