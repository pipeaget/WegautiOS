//
//  FirstNameTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodriguez on 5/20/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol FirstNameTVCellDelegate {
  func textfieldFirstNameEndEditing(text: String)
  func firstNameReturnPressed()
}

class FirstNameTVCell: UITableViewCell {

  //MARK: - VARIABLES

  var currentFirstName: String? {
    didSet {
      setUpCell()
    }
  }
  var delegate: FirstNameTVCellDelegate?

  //MARK: - OUTLETS

  @IBOutlet weak var lblFirstName: UILabel!
  @IBOutlet weak var tfFirstName: UITextField!

  //MARK: - VIEW LIFECYCLE

  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

  //MARK: - FUNCTIONS

  func setUpCell() {
    guard let aFirstName = currentFirstName else { return }
    lblFirstName.text = "REG_FN".localized
    tfFirstName.text = aFirstName
    tfFirstName.delegate = self
  }
}

extension FirstNameTVCell: UITextFieldDelegate {

  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let aString = textField.text else { return }
    delegate?.textfieldFirstNameEndEditing(text: aString)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    delegate?.firstNameReturnPressed()
    return true
  }
}
