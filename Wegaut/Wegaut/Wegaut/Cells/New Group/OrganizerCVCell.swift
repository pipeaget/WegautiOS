//
//  OrganizerCVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/17/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class OrganizerCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentOrganizer: Organizer?{
        didSet{
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwOrganizer: UIImageView!
    
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.cornerRadius(cornerRadius: 5)
        guard let anOrganizer: Organizer = currentOrganizer else{
            return
        }
        if let anURL = URL(string: anOrganizer.orgImageURL){
            imgvwOrganizer.sd_setImage(with: anURL,
                                       placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                       options: SDWebImageOptions.highPriority,
                                       completed: nil)
        }
    }
}
