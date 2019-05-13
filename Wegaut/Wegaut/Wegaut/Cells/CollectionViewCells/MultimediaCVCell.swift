//
//  MultimediaCVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/14/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit
import SDWebImage

class MultimediaCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentMultimediaFile: Multimedia? {
        didSet {
            updateCell()
        }
    }
    var currentEvent: Event? {
        didSet {
            updateCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwMultimedia: UIImageView!
    @IBOutlet weak var imgvwUser: UIImageView!
    @IBOutlet weak var lblMultimediaUserName: UILabel!
    @IBOutlet weak var lblMultimediaEventName: UILabel!
    @IBOutlet weak var lblMultimediaDate: UILabel!
    @IBOutlet weak var btnResponse: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    
    //MARK: - FUNCTIONS
    
    func updateCell() {
        
        guard let aMultimediafile = currentMultimediaFile else { return }
        if let aURL = URL(string: aMultimediafile.mulURL) {
            
            imgvwMultimedia.sd_setImage(with: aURL,
                                        placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                        options: SDWebImageOptions.highPriority,
                                        completed: nil)
        } else {
            imgvwMultimedia.image = #imageLiteral(resourceName: "BGLogo")
        }
        if let aURL = URL(string: aMultimediafile.mulUser.usProfileImageURL) {
            
            imgvwUser.sd_setImage(with: aURL,
                                        placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                        options: SDWebImageOptions.highPriority,
                                        completed: nil)
        } else {
            
            imgvwUser.image = #imageLiteral(resourceName: "BGLogo")
        }
        lblMultimediaUserName.text = User.getUserCompleteName(user: aMultimediafile.mulUser)
        if let anEvent = currentEvent {
            
            lblMultimediaEventName.text = anEvent.eveName
        } else {
            
            lblMultimediaEventName.text = "Wegaut Event"
        }
        lblMultimediaDate.text = aMultimediafile.mulDate
        btnResponse.setTitle("MUL_RESP".localized,
                             for: UIControl.State.normal)
    }
    
}
