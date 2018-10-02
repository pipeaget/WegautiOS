//
//  NewVideoTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/20/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

typealias NewVideoAction = ()->Void

class NewVideoTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var currentMultimedia: Multimedia? {
        didSet {
            drawCell()
        }
    }
    var actNewVideo: NewVideoAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnNewVideo: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        if let anImage: Data = currentMultimedia?.mulLocalVideo {
            
            btnNewVideo.setImage(#imageLiteral(resourceName: "BGLogo"),
                                 for: UIControl.State.normal)
        }
    }
    
    //MARK: - ACTIONS

    @IBAction func actNewVideo(_ sender: UIButton) {
        
        if let anAction = actNewVideo {
            
            anAction()
        }
    }
}
