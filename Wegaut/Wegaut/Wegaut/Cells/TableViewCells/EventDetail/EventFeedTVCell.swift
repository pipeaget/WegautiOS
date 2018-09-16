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
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var btnIsFavorite: UIButton!
    @IBOutlet weak var imgvwEvent: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventPlace: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    
    //MARK: VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: FUNCTIONS
    
    func drawUI(){
        
        vwContainer.layer.borderColor = UIColor.darkGray.cgColor
        vwContainer.layer.borderWidth = 2
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
        btnIsFavorite.setImage(anEvent.eveIsFavorite ? #imageLiteral(resourceName: "ICHearthON") : #imageLiteral(resourceName: "ICHearthOFF"), for: UIControlState.normal)
        lblEventName.text = anEvent.eveName
        lblEventPlace.attributedText = anEvent.evePlace.getStringWith(anImage: #imageLiteral(resourceName: "ICPin"))
        lblEventDate.attributedText = (anEvent.eveDate + ", " + anEvent.eveSchedule).getStringWith(anImage: #imageLiteral(resourceName: "ICCalendar"))
    }
    
    //MARK: ACTIONS

    @IBAction func actFavorite(_ sender: UIButton) {
        
        if let anAction = self.addRemoveFavorite{
            anAction(sender)
        }
    }
}
