//
//  SponsorshipTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/11/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class SponsorshipTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentSponsor: Sponsorship? {
        didSet {
            drawCell()
        }
    }
    var actTakePhoto: TakePhotoAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnCaptureSponsorPhoto: UIButton!
    @IBOutlet weak var tfSponsorName: UITextField!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        if let aSponsor: Sponsorship = currentSponsor {
            
            btnCaptureSponsorPhoto.setBackgroundImage(aSponsor.spoLocalImage,
                                                      for: UIControl.State.normal)
            tfSponsorName.text = aSponsor.spoName
        }
    }
    
    //MARK: - ACTIONS

    @IBAction func actBtnCaptureSponsorPhoto(_ sender: Any) {
        
        if  let anAction = self.actTakePhoto {
            
            anAction()
        }
    }
}
