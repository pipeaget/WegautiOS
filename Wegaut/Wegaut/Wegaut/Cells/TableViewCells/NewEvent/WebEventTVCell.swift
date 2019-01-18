//
//  WebEventTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 12/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

typealias openURLAction = (String) ->Void

class WebEventTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var actOpenURL: openURLAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tfEventWebURL: UITextField!
    @IBOutlet weak var btnPreviewWebPage: UIButton!
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
        tfEventWebURL.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actPreviewWebPage(_ sender: Any) {
        
        guard let aURL = tfEventWebURL.text else { return }
        if let anAction = actOpenURL {
            
            anAction(aURL)
        }
    }
}

extension WebEventTVCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text!.isAValidURL {
            
            textField.addRightImageWith(image: #imageLiteral(resourceName: "ICDone"),
                                        tintColor: UIColor.deepPurple,
                                        paddingUpDown: 0,
                                        paddingLeftRight: 0)
            
        } else {
            
            textField.addRightImageWith(image: #imageLiteral(resourceName: "ICExit"),
                                        tintColor: UIColor.deepPurple,
                                        paddingUpDown: 0,
                                        paddingLeftRight: 0)
        }
    }
}
