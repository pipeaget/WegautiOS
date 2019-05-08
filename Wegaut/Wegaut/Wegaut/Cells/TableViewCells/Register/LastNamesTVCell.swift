//
//  LastNamesTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol LastNamesTVCellDelegate {
    func textfieldLastNameEndEditing(text: String)
    func lastNamesReturnPressed()
}

class LastNamesTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentLastNames: String? {
        didSet {
            setupCell()
        }
    }
    var delegate: LastNamesTVCellDelegate?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblLastNames: UILabel!
    @IBOutlet weak var tfLastNames: UITextField!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS

    func setupCell() {
        guard let aLastName = currentLastNames else { return }
        lblLastNames.text = "REG_LN".localized
        tfLastNames.text = aLastName
        tfLastNames.delegate = self
    }
}

extension LastNamesTVCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let aString = textField.text else { return }
        delegate?.textfieldLastNameEndEditing(text: aString)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.lastNamesReturnPressed()
        return true
    }
}
