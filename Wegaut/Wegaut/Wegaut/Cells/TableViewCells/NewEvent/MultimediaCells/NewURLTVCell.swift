//
//  NewURLTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/20/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

typealias OpenURLAction = (String)->Void

class NewURLTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentMultimedia: Multimedia? {
        didSet {
            drawCell()
        }
    }
    var actOpenURL: OpenURLAction?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tfURL: UITextField!
    @IBOutlet weak var btnSeeURL: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        tfURL.placeholder = "SPO_EVURL".localized
        tfURL.delegate = self
    }
    
    //MARK: - ACTIONS

    @IBAction func actOpenURL(_ sender: UIButton) {
        
        if  let anAction = actOpenURL,
            let aURL = tfURL.text {
            
            anAction(aURL)
        }
    }
}

//MARK: - EXTENSIONS

extension NewURLTVCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text!.isAValidURL {
            
            textField.addRightImageWith(image: #imageLiteral(resourceName: "ICCheck"),
                                        tintColor: UIColor.deepPurple,
                                        paddingUpDown: 0,
                                        paddingLeftRight: 0)
        } else {
            
            textField.addRightImageWith(image: #imageLiteral(resourceName: "ICWarning"),
                                        tintColor: UIColor.red,
                                        paddingUpDown: 0,
                                        paddingLeftRight: 0)
        }
    }
}

