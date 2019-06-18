//
//  EmptyEventCVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 5/24/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol EmptyEventCVCellProtocol {
    func didTappedGoToFeed()
}

class EmptyEventCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var delegate: EmptyEventCVCellProtocol?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var imgvwEmptyMessage: UIImageView!
    @IBOutlet weak var lblEmptyMessage: UILabel!
    @IBOutlet weak var btnGoToFeed: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    func setUpCellFor(section: Int) {
        imgvwEmptyMessage.image = #imageLiteral(resourceName: "LGNavBar")
        switch section {
        case 0: lblEmptyMessage.text = "PRO_EMPTY_ MESS0".localized
        case 1: lblEmptyMessage.text = "PRO_EMPTY_ MESS1".localized
        default: lblEmptyMessage.text = "PRO_EMPTY_ MESS2".localized
        }
        btnGoToFeed.setTitle("PRO_GO_FEED".localized, for: UIControl.State.normal)
        btnGoToFeed.titleLabel?.adjustsFontSizeToFitWidth = true
        btnGoToFeed.cornerRadius(cornerRadius: 5)
    }
    
    @IBAction func actGoToFeed(_ sender: UIButton) {
        delegate?.didTappedGoToFeed()
    }
}
