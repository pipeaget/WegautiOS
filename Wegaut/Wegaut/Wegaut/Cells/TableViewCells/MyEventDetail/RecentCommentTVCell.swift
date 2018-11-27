//
//  RecentCommentTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/17/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class RecentCommentTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentComment: Comment? {
        didSet {
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwUserProfilePicture: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblTimelapse: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        guard let aComment: Comment = currentComment else { return }
        imgvwUserProfilePicture.cornerRadius(cornerRadius: nil)
        if let aURL = URL(string: aComment.comUser.usProfileImageURL){
            imgvwUserProfilePicture.sd_setImage(with: aURL,
                                                placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                                options: SDWebImageOptions.highPriority,
                                                completed: nil)
        }
        lblUser.text = User.getUserCompleteName(user: aComment.comUser)
        lblComment.text = aComment.comText
        lblTimelapse.text = aComment.comDate
    }
}
