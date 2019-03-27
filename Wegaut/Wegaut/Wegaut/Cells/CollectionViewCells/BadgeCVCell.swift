//
//  BadgeCVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/23/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

class BadgeCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentBadge: Badge?{
        didSet {
            setupCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgBadge: UIImageView!
    
    //MARK: - FUNCTIONS
    
    func setupCell() {
        
        guard let aBadge = currentBadge else { return }
        imgBadge.image = aBadge.bdImage
    }
}
