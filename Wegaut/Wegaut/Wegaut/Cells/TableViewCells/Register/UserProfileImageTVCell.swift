//
//  UserProfileImageTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol UserProfileImageTVCellDelegate {
    func photoButtonPressed()
}

class UserProfileImageTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentImage: UIImage? {
        didSet {
            setupCell()
        }
    }
    var delegate: UserProfileImageTVCellDelegate?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnChangeUserPhoto: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func setupCell() {
        guard let anImage = currentImage else { return }
        btnChangeUserPhoto.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btnChangeUserPhoto.setImage(anImage, for: UIControl.State.normal)
    }
    
    //MARK: - ACTIONS

    @IBAction func actBtnChangeUserPhoto(_ sender: UIButton) {
        delegate?.photoButtonPressed()
    }
}
