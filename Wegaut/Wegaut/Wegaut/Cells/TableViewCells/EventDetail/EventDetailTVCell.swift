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
    
    @IBOutlet weak var imgvwEvent: UIImageView!
    @IBOutlet weak var btnAddFavorite: UIButton!
    @IBOutlet weak var btnAssistEvent: UIButton!
    @IBOutlet weak var btnShareEvent: UIButton!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventInfo: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        btnAddFavorite.cornerRadius(cornerRadius: nil)
        btnAssistEvent.cornerRadius(cornerRadius: nil)
        btnShareEvent.cornerRadius(cornerRadius: nil)
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
        imgvwEvent.image = UIImage(named: anEvent.eveImageURL)
        lblEventName.text = anEvent.eveName
        let strEventInfo: NSMutableAttributedString = NSMutableAttributedString()
        let strEventPlace: NSAttributedString = NSAttributedString(string: anEvent.evePlace,
                                                                   attributes: [NSAttributedStringKey.font : UIFont(name: "Avenir", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)])
        strEventInfo.append(strEventPlace.getStringWith(anImage: #imageLiteral(resourceName: "ICPlace")))
        strEventInfo.append(NSAttributedString(string: "\n"))
        let strEventAddress: NSAttributedString = NSAttributedString(string: anEvent.eveAddress,
                                                                   attributes: [NSAttributedStringKey.font : UIFont(name: "Avenir", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)])
        strEventInfo.append(strEventAddress)
        strEventInfo.append(NSAttributedString(string: "\n"))
        let strEventDate: NSAttributedString = NSAttributedString(string: anEvent.eveDate,
                                                                   attributes: [NSAttributedStringKey.font : UIFont(name: "Avenir", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)])
        strEventInfo.append(strEventDate.getStringWith(anImage: #imageLiteral(resourceName: "ICDate")))
        strEventInfo.append(NSAttributedString(string: "\n"))
        let strEventSchedule: NSAttributedString = NSAttributedString(string: anEvent.eveSchedule,
                                                                     attributes: [NSAttributedStringKey.font : UIFont(name: "Avenir", size: 10) ?? UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)])
        strEventInfo.append(strEventSchedule)
        strEventInfo.append(NSAttributedString(string: "\n"))
        
        let strEventAssistants: NSAttributedString = NSAttributedString(string: anEvent.eveAssitants,
                                                                  attributes: [NSAttributedStringKey.font : UIFont(name: "Avenir", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)])
        strEventInfo.append(strEventAssistants.getStringWith(anImage: #imageLiteral(resourceName: "ICAssistants")))
        strEventInfo.append(NSAttributedString(string: "\n"))
        let strEventPrice: NSAttributedString = NSAttributedString(string: anEvent.evePrice,
                                                                      attributes: [NSAttributedStringKey.font : UIFont(name: "Avenir", size: 10) ?? UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)])
        strEventInfo.append(strEventPrice)
        strEventInfo.append(NSAttributedString(string: "\n"))
        lblEventInfo.attributedText = strEventInfo
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
