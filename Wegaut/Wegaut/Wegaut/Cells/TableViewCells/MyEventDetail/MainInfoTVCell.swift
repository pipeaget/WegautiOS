//
//  MainInfoTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/12/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class MainInfoTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentEvent: Event? {
        didSet {
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblAsistanceQuantity: UILabel!
    @IBOutlet weak var lblAssistants: UILabel!
    @IBOutlet weak var lblCheckInsQuantity: UILabel!
    @IBOutlet weak var lblCheckIns: UILabel!
    @IBOutlet weak var lblFollowersQuantity: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    @IBOutlet weak var lblAssistanceType: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        guard let anEvent: Event = currentEvent else { return }
        lblAsistanceQuantity.adjustsFontSizeToFitWidth = true
        lblAsistanceQuantity.text = "\(anEvent.eveAssistants)"
        lblAssistants.adjustsFontSizeToFitWidth = true
        lblAssistants.attributedText = "MIC_ASS".localized.getStringWith(anImage: #imageLiteral(resourceName: "ICFollowersOn"))
        lblCheckInsQuantity.adjustsFontSizeToFitWidth = true
        lblCheckInsQuantity.text = "\(anEvent.eveCheckIns)"
        lblCheckIns.adjustsFontSizeToFitWidth = true
        lblCheckIns.attributedText = "MIC_CHE".localized.getStringWith(anImage: #imageLiteral(resourceName: "ICPin"))
        lblFollowersQuantity.adjustsFontSizeToFitWidth = true
        lblFollowersQuantity.text = "\(anEvent.eveFollowers)"
        lblFollowers.adjustsFontSizeToFitWidth = true
        lblFollowers.attributedText = "MIC_FOL".localized.getStringWith(anImage: #imageLiteral(resourceName: "ICEye"))
        lblPlace.adjustsFontSizeToFitWidth = true
        lblPlace.attributedText = anEvent.evePlace.getStringWith(anImage: #imageLiteral(resourceName: "ICPin"))
        lblSchedule.adjustsFontSizeToFitWidth = true
        lblSchedule.attributedText = anEvent.eveSchedule.getStringWith(anImage: #imageLiteral(resourceName: "ICCalendar"))
        lblAssistanceType.adjustsFontSizeToFitWidth = true
        lblAssistanceType.attributedText = (anEvent.eveStatus ? "MIC_AVA".localized : "MIC_NAVA".localized).getStringWith(anImage: #imageLiteral(resourceName: "ICTicket"))
    }

}
