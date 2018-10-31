//
//  NSMutableAttributedStringExtensions.swift
//  Biometría Banorte
//
//  Created by Felipe Ortega on 6/22/18.
//  Copyright © 2018 Banorte. All rights reserved.
//

import UIKit

extension NSMutableAttributedString{
    
    /// Used to add a centered image as an attachment in a NSMutableAttributedString.
    ///
    /// - Parameters:
    ///   - anImage: The image you want to append to the text.
    ///   - inLeftPosition: The position (Left/Right) where you want to append the image.
    ///   - currentFont: The font of the text.
    /// - Returns: An NSMutableAttributedString with the image appended in the specified position.
    func with(anImage: UIImage, inLeftPosition: Bool, currentFont: UIFont)->NSMutableAttributedString{
        
        let strToReturn: NSMutableAttributedString = NSMutableAttributedString()
        let imgAttachment: NSTextAttachment = NSTextAttachment()
        imgAttachment.bounds = CGRect(x: 0,
                                      y: (currentFont.capHeight - anImage.size.height).rounded() / 2,
                                      width: anImage.size.width,
                                      height: anImage.size.height)
        imgAttachment.image = anImage
        let strImage: NSAttributedString = NSAttributedString(attachment: imgAttachment)
        strToReturn.append(inLeftPosition ? strImage : self)
        strToReturn.append(NSMutableAttributedString(string: " "))
        strToReturn.append(inLeftPosition ? self : strImage)
        return strToReturn
    }
    
    /// Used to assign an specific line spacing to a NSMutableattributedString.
    ///
    /// - Parameter lineSpacing: The line spacing you want to assign to the string.
    /// - Returns: A NSMutableAttributedString with the specified line spacing.
    func with(lineSpacing: CGFloat)->NSMutableAttributedString{
        
        let strToReturn: NSMutableAttributedString = NSMutableAttributedString(attributedString: self)
        
        let customParagraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        customParagraphStyle.lineSpacing = lineSpacing
        strToReturn.addAttributes([NSAttributedString.Key.paragraphStyle : customParagraphStyle],
                                  range: NSMakeRange(0, strToReturn.length))
        
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
