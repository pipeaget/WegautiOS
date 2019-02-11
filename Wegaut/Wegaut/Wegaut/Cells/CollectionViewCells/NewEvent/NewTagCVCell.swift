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
    
    @IBOutlet weak var imgvwTag: UIImageView!
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        self.layer.cornerRadius = self.frame.width / 2
        guard let aTag = currentTag else { return }
        imgvwTag.image = aTag.tagStateImage
        self.backgroundColor = aTag.tagIsSelected ? UIColor.white : UIColor.deepPurple
    }
}
