//
//  UIImageViewExtensions.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/16/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func get(image:UIImage?, with tintColor:UIColor?){
        
        if let anImage = image {
            let imageToColor: UIImage = anImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            if let aTintColor = tintColor {
                
                self.tintColor = aTintColor
            }
            self.image = imageToColor
        }
    }
}
