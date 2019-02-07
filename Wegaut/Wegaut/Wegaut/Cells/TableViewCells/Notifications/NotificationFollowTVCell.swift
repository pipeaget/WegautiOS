//
//  NotificationFollowTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

typealias followAction = (Bool)-> Void

class NotificationFollowTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentNotification: Activity? {
        didSet{
            drawCell()
        }
    }
    var actFollow: followAction?
    
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
        }
        lblUser.text = User.getUserCompleteName(user: anUser)
        lblNotification.text = aNotification.actTitle
        lblTimelapse.text = "\(aNotification.actDate)"
        btnFollow.isHidden = false
        btnFollow.cornerRadius(cornerRadius: 5)
        btnFollow.setTitle(aNotification.actType.description,
                           for: UIControl.State.normal)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnFollow(_ sender: UIButton) {
        
        guard let aNotification = currentNotification else { return }
        if let anAction = self.actFollow {
            
            anAction(aNotification.actType == activityType.newFollowing ? true : false)
        }
    }
}
