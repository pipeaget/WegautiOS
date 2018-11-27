//
//  EventFeedTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/11/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

typealias addRemoveFavorite = (UIButton)->Void

class EventFeedTVCell: UITableViewCell {
    
    //MARK: VARIABLES
    
    var addRemoveFavorite:addRemoveFavorite?
    var currentEvent:Event?{
        didSet{
            drawUI()
        }
    }
    
    //MARK: OUTLETS
    
    @IBOutlet weak var imgvwEvent: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventPlace: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var btnIsFavorite: UIButton!
    @IBOutlet weak var lblLikes: UILabel!
    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
    //MARK: VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: FUNCTIONS
    
    func drawUI(){
        
        vwContainer.layer.masksToBounds = true
        vwContainer.cornerRadius(cornerRadius: 10)
        guard let anEvent = currentEvent else {
            return
        }
        /*if let anURL = URL(string: anEvent.eveImageURL){
            imgvwEvent.sd_setImage(with: anURL, placeholderImage: #imageLiteral(resourceName: "BGLogo"), options: SDWebImageOptions.highPriority, completed: nil)
        }*/
        imgvwEvent.image = UIImage(named: anEvent.eveImageURL)
        imgvwEvent.clipsToBounds = true
        imgvwEvent.cornerRadius(cornerRadius: 10)
        //btnIsFavorite.setImage(anEvent.eveUserFavorited ? #imageLiteral(resourceName: "ICHearthON") : #imageLiteral(resourceName: "ICHearthOFF"), for: UIControl.State.normal)
        lblEventName.text = anEvent.eveName
        lblEventPlace.attributedText = anEvent.evePlace.getStringWith(anImage: #imageLiteral(resourceName: "ICPlace"))
        lblEventDate.attributedText = (anEvent.eveDate + ", " + anEvent.eveSchedule).getStringWith(anImage: #imageLiteral(resourceName: "ICDate"))
    }
    
    //MARK: ACTIONS

    @IBAction func actFavorite(_ sender: UIButton) {
        
        if let anAction = self.addRemoveFavorite{
            anAction(sender)
        }
    }
}
