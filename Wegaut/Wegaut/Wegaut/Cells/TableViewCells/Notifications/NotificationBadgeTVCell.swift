//
//  NotificationBadgeTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

typealias seeMedalAction = ()-> Void

class NotificationBadgeTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentNotification: Activity?{
        didSet{
            drawCell()
        }
    }
    var actSeeMedal: seeMedalAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblTimelapse: UILabel!
    @IBOutlet weak var btnBadge: UIButton!
    
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
              let aUser = aNotification.actUser else{
            return
        }
        vwContainer.cornerRadius(cornerRadius: 10)
        lblUser.text = User.getUserCompleteName(user: aUser)
        lblNotification.text = aNotification.actTitle
        lblTimelapse.text = "\(aNotification.actDate)"
        btnBadge.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnBadge(_ sender: UIButton) {
        
        if let anAction = self.actSeeMedal {
            
            anAction()
        }
    }
}
