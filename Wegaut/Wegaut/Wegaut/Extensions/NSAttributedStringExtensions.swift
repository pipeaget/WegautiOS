//
//  NSAttributedStringExtensions.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/19/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    /// Used to add an image to a NSAttributedString as a NSAttachment.
    ///
    /// - Parameter anImage: The image you want to add to the NSAttributedString.
    /// - Returns: The NSAttributedString with the image.
    func getStringWith(anImage: UIImage)->NSAttributedString {
        
        let strToReturn = NSMutableAttributedString(string: "")
        let imgAttachment = NSTextAttachment()
        var image = anImage
        image = image.resize(targetSize: CGSize(width: 20, height: 20))
        imgAttachment.image = image
        let imgString = NSAttributedString(attachment: imgAttachment)
        strToReturn.append(imgString)
        strToReturn.append(NSAttributedString(string: " "))
        strToReturn.append(self)
        return strToReturn
    }
}
