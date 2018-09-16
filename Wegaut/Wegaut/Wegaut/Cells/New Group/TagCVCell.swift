//
//  TagCVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class TagCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentTag: (Tag, Bool)? {
        didSet{
            updateView()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwSelectionState: UIImageView!
    @IBOutlet weak var lblTagName: UILabel!
    
    //MARK: - FUNCTIONS
    
    func updateView() {
        
        guard let aTag: (Tag, Bool) = currentTag else {
            
            return
        }
        imgvwSelectionState.image = aTag.1 ? #imageLiteral(resourceName: "ICCircleOn") : #imageLiteral(resourceName: "ICCircleOff")
        lblTagName.text = aTag.0.tagName
    }
}
