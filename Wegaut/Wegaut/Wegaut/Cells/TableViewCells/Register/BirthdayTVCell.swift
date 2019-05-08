//
//  BirthdayTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol BirthdayTVCellDelegate {
    func textfieldBirthdayPressed()
    func textfieldBirthdayEndEditing(text: String)
    func birthdayReturnPressed()
}

class BirthdayTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var currentBirthday: String? {
        didSet {
            setupCell()
        }
    }
    var delegate: BirthdayTVCellDelegate?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var tfBirthday: UITextField!
    
    //MARK: - VIEW LIFECYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func setupCell() {
        guard let aBirthday = currentBirthday else { return }
        lblBirthday.text = "REG_BIRTH".localized
        tfBirthday.text = aBirthday
        tfBirthday.delegate = self
    }
}

extension BirthdayTVCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.textfieldBirthdayPressed()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let aString = textField.text else { return }
        delegate?.textfieldBirthdayEndEditing(text: aString)
        delegate?.birthdayReturnPressed()
    }
}
