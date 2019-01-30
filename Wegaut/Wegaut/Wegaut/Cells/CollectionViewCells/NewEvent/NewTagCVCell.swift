//
//  NewTagCVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 12/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class NewTagCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentTag: Tag? {
        didSet {
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnTagImage: UIButton!
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        guard let aTag = currentTag else { return }
        btnTagImage.setImage(aTag.tagImage,
                                    for: UIControl.State.normal)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actSelectDeselectTag(_ sender: UIButton) {
        
        guard var aTag = currentTag else { return }
        aTag.tagIsSelected = !aTag.tagIsSelected
    }
}
