//
//  UIImageViewExtensions.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/16/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getImageWith(tintColor:UIColor?) {
        
        if let anImage = self.image {
            let imageToColor: UIImage = anImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            if let aTintColor = tintColor {
                
                self.tintColor = aTintColor
            }
            self.image = imageToColor
        }
    }
}
