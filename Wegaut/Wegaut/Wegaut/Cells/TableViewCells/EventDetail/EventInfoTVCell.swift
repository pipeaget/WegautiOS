//
//  EventInfoTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/20/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class EventInfoTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentEvent: Event? {
        didSet{
            updateCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblAboutTitle: UILabel!
    @IBOutlet weak var lblAbout: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func updateCell() {
        
        guard let anEvent = currentEvent else { return }
        lblAboutTitle.text = "EIVC_TIT".localized
        lblAbout.text = anEvent.eveDescription
    }
}
