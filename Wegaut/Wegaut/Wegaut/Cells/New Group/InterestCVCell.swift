//
//  InterestCVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/16/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class InterestCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentInterest: Interest? {
        didSet {
            updateView()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwInterest: UIImageView!
    
    //MARK: - FUNCTIONS
    
    func updateView() {
        
        self.cornerRadius(cornerRadius: nil)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        guard let anInterest = currentInterest else { return }
        imgvwInterest.get(image: anInterest.inImage, with: anInterest.inIsSelected ? UIColor.mediumPurple : UIColor.white)
        self.backgroundColor = anInterest.inIsSelected ? UIColor.white : UIColor.clear
    }
}
