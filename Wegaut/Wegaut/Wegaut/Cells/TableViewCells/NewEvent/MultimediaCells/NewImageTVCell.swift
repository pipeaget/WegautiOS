//
//  NewImageTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/20/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

typealias NewImageAction = ()->Void

class NewImageTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var currentMultimedia: Multimedia? {
        didSet {
           drawCell()
        }
    }
    var actNewImage: NewImageAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnNewImage: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        if let anImage: UIImage = currentMultimedia?.mulLocalImage {
            
            btnNewImage.setImage(anImage,
                                 for: UIControl.State.normal)
        }
    }
    
    //MARK: - ACTIONS

    @IBAction func actNewImage(_ sender: UIButton) {
        
        if let anAction = actNewImage {
            
            anAction()
        }
    }
}
