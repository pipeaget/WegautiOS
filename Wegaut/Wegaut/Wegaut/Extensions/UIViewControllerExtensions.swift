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
    
    /// Used to add the Aeneas Logo to the navigation bar.
    func addImageLogoToNavBar(){
        
        if let aNavigationBar = self.navigationController{
            if !aNavigationBar.isNavigationBarHidden{
                let logoContainer:UIView = UIView(frame: CGRect(x: 0,
                                                                y: 0,
                                                                width: 270,
                                                                height: 30))
                let imageView = UIImageView(frame: CGRect(x: 0,
                                                          y: 0,
                                                          width: 270,
                                                          height: 30))
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                imageView.image = UIImage(imageLiteralResourceName: "LGNavBar")
                logoContainer.addSubview(imageView)
                navigationItem.titleView = logoContainer
            }
        }
    }
}
