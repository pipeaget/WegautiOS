//
//  MFMailComposeViewControllerExtension.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import MessageUI

extension MFMailComposeViewController {
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = false
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.deepPurple
    }
}
