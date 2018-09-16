//
//  NSMutableAttributedStringExtensions.swift
//  Biometría Banorte
//
//  Created by Felipe Ortega on 6/22/18.
//  Copyright © 2018 Banorte. All rights reserved.
//

import UIKit

extension NSMutableAttributedString{
    
    func getStringWith(aLineSpacing: CGFloat)->NSMutableAttributedString{
        
        let strToReturn: NSMutableAttributedString = self
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = aLineSpacing
        strToReturn.addAttribute(NSAttributedStringKey.paragraphStyle,
                                 value: paragraphStyle,
                                 range: NSMakeRange(0,
                                                    strToReturn.length))
        return strToReturn
    }
    
    /// Used to add an image to a NSAttributedString as a NSAttachment.
    ///
    /// - Parameter anImage: The image you want to add to the NSAttributedString.
    /// - Returns: The NSAttributedString with the image.
    func getStringWith(anImage: UIImage, isInLeftPosition:Bool, currentFont: UIFont)->NSAttributedString {
        
        let strToReturn = NSMutableAttributedString(string: String())
        let imgAttachment = NSTextAttachment()
        imgAttachment.bounds = CGRect(x: 0,
                                      y: (currentFont.capHeight - anImage.size.height).rounded() / 2,
                                      width: anImage.size.width,
                                      height: anImage.size.height)
        imgAttachment.image = anImage
        let imgString = NSAttributedString(attachment: imgAttachment)
        if isInLeftPosition{
            
            strToReturn.append(imgString)
            strToReturn.append(NSAttributedString(string: " "))
            strToReturn.append(self)
        }else{
            
            strToReturn.append(self)
            strToReturn.append(NSAttributedString(string: " "))
            strToReturn.append(imgString)
        }
        return strToReturn
    }
}
