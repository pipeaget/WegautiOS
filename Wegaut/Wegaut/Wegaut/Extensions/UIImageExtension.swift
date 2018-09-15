//
//  UIImageExtension.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/11/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resize(targetSize: CGSize) -> UIImage {
        
        return UIGraphicsImageRenderer(size:targetSize).image {
            _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
