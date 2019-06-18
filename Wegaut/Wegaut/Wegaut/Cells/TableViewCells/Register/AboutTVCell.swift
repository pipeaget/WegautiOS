//
//  AboutTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/30/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

protocol AboutTVCellDelegate {
    func textfieldAboutEndEditing(text: String)
    func aboutReturnPressed()
}

class AboutTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var currentAbout: String? {
        didSet {
            setupCell()
        }
    }
    var delegate: AboutTVCellDelegate?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var txtvwAbout: UITextView!
    @IBOutlet weak var lblCount: UILabel!
    
    //MARK: - VIEW LIFECYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS

    func setupCell() {
        guard let anAbout = currentAbout else { return }
        lblAbout.text = "REG_ABOUT".localized
        lblCount.text = txtvwAbout.text.isEmpty ? "0/250" : "\(self.txtvwAbout.text.count) / 100"
        lblCount.textColor = txtvwAbout.text.count == 250 ? UIColor.red : UIColor.black
        txtvwAbout.text = anAbout
        txtvwAbout.delegate = self
    }
    
    @objc func aboutEndEditing() {
        self.endEditing(true)
        delegate?.aboutReturnPressed()
    }
}

extension AboutTVCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.size.width,
                                                        height: 44))
        let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                                            target: self,
                                                            action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "OK",
                                                         style: UIBarButtonItem.Style.done,
                                                         target: self,
                                                         action: #selector(self.aboutEndEditing))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.tintColor = UIColor.black
        textView.inputAccessoryView = toolBar
        textView.inputAccessoryView = toolBar
        if textView.text == "REG_DESC".localized {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            
            textView.text = "REG_DESC".localized
        } else {
            
            textView.text = textView.text.trimmingCharacters(in: .whitespaces)
        }
        delegate?.textfieldAboutEndEditing(text: textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if (self.txtvwAbout == textView) {
            
            if (range.location == 0 && text.isEmpty) {
                
                return false
            }
            if (text.rangeOfCharacter(from: .newlines) == nil && (textView.text! + text).count <= 100) {
                
                self.lblCount.text = "\(self.txtvwAbout.text.count + text.count) / 100"
                self.lblCount.textColor = UIColor.black
                return true
            } else {
                
                self.lblCount.textColor = UIColor.red
                return false
            }
        }
        return true
    }
}
