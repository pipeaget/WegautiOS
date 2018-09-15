//
//  UIViewControllerExtensions.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/13/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
}
