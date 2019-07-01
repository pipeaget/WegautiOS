//
//  PasswordTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol PasswordTVCellDelegate {
    func passwordReturnPressed()
}

class PasswordTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var currentPassword: String? {
        didSet {
            setupCell()
        }
    }
    var delegate: PasswordTVCellDelegate?
    var passwordsAreEqual: Bool = true
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    
    //MARK: - VIEW LIFECYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS

    func setupCell() {
        guard let aPassword = currentPassword else { return }
        lblPassword.text = "REG_PSSWD".localized
        tfPassword.text = aPassword
        tfPassword.textColor = UIColor.red
        tfPassword.delegate = self
    }
}

extension PasswordTVCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblPassword.text = "REG_PSSWD_COND".localized
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        lblPassword.text = "REG_PSSWD".localized
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.passwordReturnPressed()
        return true
    }
}
