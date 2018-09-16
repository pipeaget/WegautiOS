//
//  EventDetailTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/18/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

typealias actAddFavorite = (Event)->Void
typealias actAssistEvent = (Event)->Void
typealias actShareEvent = (Event)->Void

class EventDetailTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentEvent: Event?{
        didSet{
            drawCell()
        }
    }
    var addFavorite: actAddFavorite?
    var assistEvent: actAssistEvent?
    var shareEvent: actShareEvent?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgvwEvent: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var vwDivider1: UIView!
    @IBOutlet weak var vwButtonContainer: UIView!
    @IBOutlet weak var btnAddFavorite: UIButton!
    @IBOutlet weak var lblAddFavorite: UILabel!
    @IBOutlet weak var btnAddEvent: UIButton!
    @IBOutlet weak var lblGoingTo: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblShare: UILabel!
    @IBOutlet weak var vwDivider2: UIView!
    @IBOutlet weak var lblEventPlace: UILabel!
    @IBOutlet weak var lblEventAddress: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventSchedule: UILabel!
    @IBOutlet weak var lblEventAssistance: UILabel!
    @IBOutlet weak var lblEventOrganizer: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        vwContainer.layer.borderColor = UIColor.lightGray.cgColor
        vwContainer.layer.borderWidth = 0.5
        vwContainer.layer.masksToBounds = true
        vwContainer.cornerRadius(cornerRadius: 1)
        btnShare.cornerRadius(cornerRadius: 1)
        lblAddFavorite.text = "EDC_INT".localized
        lblGoingTo.text = "EDC_GOI".localized
        lblShare.text = "EDC_SHA".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS

    func drawCell(){
    
        guard let anEvent: Event = currentEvent else{
            
            return
        }
        /*if let anURL = URL(string: anEvent.eveImageURL){
            imgvwEvent.sd_setImage(with: anURL,
                                   placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                   options: SDWebImageOptions.highPriority,
                                   completed: nil)
        }*/
        imgvwEvent.clipsToBounds = true
        imgvwEvent.image = UIImage(named: anEvent.eveImageURL)
        lblEventName.text = anEvent.eveName
        lblDescription.text = anEvent.eveDescription
        lblEventPlace.attributedText = anEvent.evePlace.getStringWith(anImage: #imageLiteral(resourceName: "ICPin"))
        lblEventAddress.text = anEvent.eveAddress
        lblEventDate.attributedText = anEvent.eveDate.getStringWith(anImage: #imageLiteral(resourceName: "ICCalendar"))
        lblEventSchedule.text = anEvent.eveSchedule
        lblEventAssistance.attributedText = anEvent.eveAssitants.getStringWith(anImage: #imageLiteral(resourceName: "ICTicket"))
        lblEventOrganizer.text = anEvent.eveOrganizers.first?.orgName ?? ""
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actAddFavorite(_ sender: UIButton) {
        
        if  let anAction = addFavorite,
            let anEvent = currentEvent{
            
            anAction(anEvent)
        }
    }
    
    @IBAction func actAddEvent(_ sender: UIButton) {
        
        if  let anAction = assistEvent,
            let anEvent = currentEvent{
            
            anAction(anEvent)
        }
    }
    
    @IBAction func actShareEvent(_ sender: UIButton) {
        
        if  let anAction = shareEvent,
            let anEvent = currentEvent{
            
            anAction(anEvent)
        }
    }
}
