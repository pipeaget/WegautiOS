//
//  UsernameTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol UsernameTVCellDelegate {
    func textfieldUsernameEndEditing(text: String)
    func usernameReturnPressed()
}

class UsernameTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentName: String? {
        didSet {
            setupCell()
        }
    }
    var delegate: UsernameTVCellDelegate?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var tfUsername: UITextField!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func setupCell() {
        guard let aName = currentName else { return }
        lblUsername.text = "REG_USR".localized
        tfUsername.text = aName
        tfUsername.delegate = self
    }
}

extension UsernameTVCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let aString = textField.text else { return }
        delegate?.textfieldUsernameEndEditing(text: aString)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.usernameReturnPressed()
        return true
    }
}
