//
//  PasswordTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol PasswordTVCellDelegate {
    func passwordReturnPressed(arePasswordsEqual: Bool)
}

class PasswordTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var currentPassword: String? {
        didSet {
            setupCell()
        }
    }
    var delegate: PasswordTVCellDelegate?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var btnConfirmPassword: UIButton!
    
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
        lblPassword.text = "REG_PSSWDS".localized
        tfPassword.tag = 0
        tfPassword.text = aPassword
        tfPassword.placeholder = "REG_PSSWD".localized
        tfPassword.textColor = UIColor.black
        tfPassword.isSecureTextEntry = true
        tfPassword.rightViewMode = UITextField.ViewMode.whileEditing
        tfPassword.delegate = self
        tfConfirmPassword.tag = 1
        tfConfirmPassword.text = ""
        tfConfirmPassword.placeholder = "REG_CONFPSSWD".localized
        tfConfirmPassword.textColor = UIColor.black
        tfConfirmPassword.isSecureTextEntry = false
        tfConfirmPassword.rightViewMode = UITextField.ViewMode.whileEditing
        tfConfirmPassword.delegate = self
        btnPassword.isHidden = true
        btnConfirmPassword.isHidden = true
    }
    
    func validatePasswords() -> Bool {
        if tfConfirmPassword.text!.isAValidPassword && tfPassword.text!.isAValidPassword && (tfPassword.text! == tfConfirmPassword.text!) {
            return true
        } else {
            tfConfirmPassword.textColor = UIColor.red
            tfPassword.textColor = UIColor.red
            return false
        }
    }
    
    func getCorrespondingTextFieldView(string: String?) -> UIImageView? {
        guard let aString = string else { return nil }
        return UIImageView(image: aString.isAValidPassword ? #imageLiteral(resourceName: "ICSuccess.png") : #imageLiteral(resourceName: "ICFail.png"))
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnPassword(_ sender: UIButton) {
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry
        sender.setImage(tfPassword.isSecureTextEntry ? #imageLiteral(resourceName: "ICVisibleOn.png") : #imageLiteral(resourceName: "ICVisibleOff.png") , for: UIControl.State.normal)
    }
    
    @IBAction func actConfirmPassword(_ sender: UIButton) {
        tfConfirmPassword.isSecureTextEntry = !tfConfirmPassword.isSecureTextEntry
        sender.setImage(tfConfirmPassword.isSecureTextEntry ? #imageLiteral(resourceName: "ICVisibleOn.png") : #imageLiteral(resourceName: "ICVisibleOff.png") , for: UIControl.State.normal)
    }
}

extension PasswordTVCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tfPassword.textColor = UIColor.black
        tfConfirmPassword.textColor = UIColor.black
        btnPassword.isHidden = tfPassword.text!.isEmpty
        btnConfirmPassword.isHidden = tfConfirmPassword.text!.isEmpty
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            btnPassword.isHidden = (tfPassword.text! + string).isEmpty
        } else {
            btnConfirmPassword.isHidden = (tfConfirmPassword.text! + string).isEmpty
        }
        textField.rightView = getCorrespondingTextFieldView(string: textField.text! + string)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            delegate?.passwordReturnPressed(arePasswordsEqual: validatePasswords())
        }
    }
}
