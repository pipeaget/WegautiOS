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
    
    var currentInterest: Tag? {
        didSet {
            updateView()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwInterest: UIImageView!
    
    //MARK: - FUNCTIONS
    
    func updateView() {
        
        self.cornerRadius(cornerRadius: nil)
        self.layer.borderWidth = 2
        guard let anInterest = currentInterest else { return }
        imgvwInterest.image = anInterest.tagStateImage
        self.layer.borderColor = UIColor.deepPurple.cgColor
        self.backgroundColor = anInterest.tagIsSelected ? UIColor.deepPurple : UIColor.white
    }
}
