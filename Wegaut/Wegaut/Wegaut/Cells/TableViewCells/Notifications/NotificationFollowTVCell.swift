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
    
    //MARK: - VARIABLES
    
    var currentNotification: UserNotification?{
        didSet{
            drawCell()
        }
    }
    
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
        vwContainer.cornerRadius(cornerRadius: 10)
        imgvwProfilePic.cornerRadius(cornerRadius: nil)
        if let anURL = URL(string: aNotification.notProfImageURL){
            
            imgvwProfilePic.sd_setImage(with: anURL,
                                        placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                        options: SDWebImageOptions.highPriority,
                                        completed: nil)
        }
        lblUser.text = aNotification.notUsername
        lblNotification.text = aNotification.notContent
        lblTimelapse.text = aNotification.notCreationDate
        btnFollow.cornerRadius(cornerRadius: 5)
        btnFollow.setTitle("NOT_FOLLOW".localized, for: UIControl.State.normal)
    }

}
