//
//  SimpleDetailVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class SimpleDetailVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var currentSettingOption: SettingsOption? 
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvwDetail: UITextView!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let aCurrentOption = currentSettingOption else{
            return
        }
        lblTitle.text = aCurrentOption.SOTitle
        lblTitle.numberOfLines = 0
        self.addImageLogoToNavBar()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
