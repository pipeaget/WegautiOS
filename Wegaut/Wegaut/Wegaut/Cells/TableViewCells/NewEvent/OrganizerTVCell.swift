//
//  OrganizerTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/11/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class OrganizerTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentOrganizer: Organizer? {
        didSet{
            drawCell()
        }
    }
    var actTakePhoto: TakePhotoAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnCaptureOrganizerPhoto: UIButton!
    @IBOutlet weak var tfOrganizerName: UITextField!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        if let anOrganizer: Organizer = currentOrganizer {
            
            btnCaptureOrganizerPhoto.setBackgroundImage(anOrganizer.orgLocalImage, for: UIControl.State.normal)
            tfOrganizerName.text = anOrganizer.orgName
        }
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnCaptureOrganizerPhoto(_ sender: UIButton) {
        
        if let anAction = self.actTakePhoto {
            
            anAction()
        }
    }
    
}
