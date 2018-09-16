//
//  EventCVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class EventCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentEvent: Event?{
        didSet{
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwEvent: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.cornerRadius(cornerRadius: 5)
        guard let anEvent = currentEvent else{
            
            return
        }
        /*if let anURL = URL(string: anEvent.eveImageURL){
            
            imgvwEvent.sd_setImage(with: anURL,
                                   placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                   options: SDWebImageOptions.highPriority,
                                   completed: nil)
        }*/
        imgvwEvent.image = UIImage(named: anEvent.eveImageURL)
        imgvwEvent.clipsToBounds = true
        lblEventName.text = anEvent.eveName
    }
}
