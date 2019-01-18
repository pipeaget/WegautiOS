//
//  NotificationFollowTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class NotificationFollowTVCell: UITableViewCell {
    
    //MARK: - ENUMS
    
    enum notificationFollowerType {
        
        case follwing
        case follower
        case noExists
        
        var description: String {
            
            switch self {
                
            case notificationFollowerType.follower: return "NOT_FOLLOW".localized
            case notificationFollowerType.follwing: return "NOT_FLWING".localized
            case notificationFollowerType.noExists: return ""
                
            }
        }
    }
    
    //MARK: - VARIABLES
    
    var currentNotification: Activity?{
        didSet{
            drawCell()
        }
    }
    
    var currentFollowerType: notificationFollowerType?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgvwProfilePic: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblTimelapse: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        guard let aNotification = currentNotification else{
            return
        }
        getFollowerType()
        vwContainer.cornerRadius(cornerRadius: 10)
        imgvwProfilePic.cornerRadius(cornerRadius: nil)
        if let anURL = URL(string: aNotification.actUser.usProfileImageURL){
            
            imgvwProfilePic.sd_setImage(with: anURL,
                                        placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                        options: SDWebImageOptions.highPriority,
                                        completed: nil)
        }
        lblUser.text = User.getUserCompleteName(user: aNotification.actUser)
        lblNotification.text = aNotification.actTitle
        lblTimelapse.text = "\(aNotification.actDate)"
        btnFollow.isHidden = false
        btnFollow.cornerRadius(cornerRadius: 5)
        if let aFollowerType = currentFollowerType {
            
            btnFollow.setTitle(aFollowerType.description, for: UIControl.State.normal)
        } else {
            
            btnFollow.isHidden = true
        }
    }
    
    func getFollowerType(){
        
        switch currentNotification!.actType {
            
        case activityType.newFollower:  currentFollowerType = notificationFollowerType.follower
        case activityType.newFollowing: currentFollowerType = notificationFollowerType.follwing
        default:                        currentFollowerType = notificationFollowerType.noExists
        }
    }
}
