//
//  NotificationBadgeTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class NotificationBadgeTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentNotification: UserNotification?{
        didSet{
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblTimelapse: UILabel!
    @IBOutlet weak var imgvwBadge: UIImageView!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        guard let aNotification = currentNotification else{
            return
        }
        vwContainer.cornerRadius(cornerRadius: 10)
        lblUser.text = aNotification.notUsername
        lblNotification.text = aNotification.notContent
        lblTimelapse.text = aNotification.notCreationDate
    }
}
