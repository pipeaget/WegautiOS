//
//  FollowersTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/21/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit
import SDWebImage

class FollowersTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentFollower: User? {
        didSet {
            drawCell()
        }
    }
    var isFollower: Bool = true {
        didSet {
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwProfileImage: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        guard let aFollower = currentFollower else { return }
        if let aURL = URL(string: aFollower.usProfileImageURL) {
            
            imgvwProfileImage.sd_setImage(with: aURL,
                                          placeholderImage: #imageLiteral(resourceName: "LGNavBar"), options: SDWebImageOptions.highPriority, completed: nil)
        } else {
            
            imgvwProfileImage.image = #imageLiteral(resourceName: "LGNavBar")
        }
        lblUsername.text = aFollower.usName
        btnFollow.isHidden = true
    }
    
    //MARK: - ACTIONS

    @IBAction func actFollow(_ sender: UIButton) {
        
        //TODO: SEND
    }
}
