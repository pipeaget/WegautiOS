//
//  EmailTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol EmailTVCellDelegate {
    func textfieldEmailEndEditing(text: String)
    func emailReturnPressed()
}

class EmailTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentEmail: String? {
        didSet {
            setupCell()
        }
    }
    var delegate: EmailTVCellDelegate?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS

    func setupCell() {
        guard let anEmail = currentEmail else { return }
        lblEmail.text = "REG_EM".localized
        tfEmail.text = anEmail
        tfEmail.delegate = self
    }
}

extension EmailTVCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let aString = textField.text else { return }
        delegate?.textfieldEmailEndEditing(text: aString)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.emailReturnPressed()
        return true
    }
}
