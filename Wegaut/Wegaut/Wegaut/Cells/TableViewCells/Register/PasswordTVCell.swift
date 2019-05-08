//
//  PasswordTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol PasswordTVCellDelegate {
    func textfieldPasswordEndEditing(text: String, isConfirm: Bool)
    func passwordReturnPressed(isConfirm: Bool)
}

class PasswordTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var currentPassword: String? {
        didSet {
            setupCell()
        }
    }
    var delegate: PasswordTVCellDelegate?
    var isConfirmationPassword: Bool = false
    var isVisible: Bool = true {
        didSet{
            updateVisibility()
        }
    }
    var passwordsAreEqual: Bool = true
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnVisibleInvisible: UIButton!
    
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
        lblPassword.text = isConfirmationPassword ? "REG_CPSSWD".localized : "REG_PSSWD".localized
        tfPassword.text = aPassword
        tfPassword.textColor = passwordsAreEqual ? UIColor.black : UIColor.red
        tfPassword.delegate = self
        updateVisibility()
    }
    
    func updateVisibility() {
        tfPassword.isSecureTextEntry = isVisible
        btnVisibleInvisible.setImage(isVisible ? #imageLiteral(resourceName: "ICVisible") : #imageLiteral(resourceName: "ICInvisible.png"), for: UIControl.State.normal)
        btnVisibleInvisible.imageView?.getImageWith(tintColor: UIColor.deepPurple)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnVisibleInvisible(_ sender: UIButton) {
        isVisible = !isVisible
        updateVisibility()
    }
}

extension PasswordTVCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let aString = textField.text else { return }
        delegate?.textfieldPasswordEndEditing(text: aString, isConfirm: isConfirmationPassword)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.passwordReturnPressed(isConfirm: isConfirmationPassword)
        return true
    }
}
