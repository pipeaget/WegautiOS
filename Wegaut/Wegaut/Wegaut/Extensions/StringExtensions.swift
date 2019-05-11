//
//  StringExtensions.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

extension String{
    
    /// Used to get the corresponding localized text (text according to default language in the device; otherwise default specified by app).
    var localized: String {
        
        return NSLocalizedString(self,
                                                   tableName:nil,
                                                   bundle: Bundle.main,
                                                   value: "",
                                                   comment: "") as String
    }
    
    func localizeString(_ language: String) -> String {
        guard let path = Bundle.main.path (forResource: language, ofType: "lproj"), let languageBundle = Bundle(path: path) else { return "" }
        return languageBundle.localizedString(forKey: self, value: "", table: nil)
    }
    
    /// Used to validate if a string is a valid email
    var isAValidEmail:Bool{
        let emailregex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailregex)
        return emailTest.evaluate(with:self)
    }
    
    var isAValidURL: Bool {
        
        let urlRegex = "[-\\w\\.]++(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        return urlTest.evaluate(with: self)
    }
    
    func stringToDateEddMMMyyyy()-> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM yyyy"
        guard let date = dateFormatter.date(from: self) else { return Date() }
        return date
    }
    
    /// Used to replace diagonals with dash
    var dateSendFormat:String{
        
        return self.replacingOccurrences(of: "-", with: "/",
                                         options: NSString.CompareOptions.literal, range:nil)
    }
    
    /// Used to set a foreground/text color to an NSAttributed string
    ///
    /// - Parameter aColor: The color you want to set. Default is black
    /// - Returns: An NSAttributedString with the foreground/text color requested.
    func setColorText(aColor:UIColor?)->NSAttributedString{
        
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor : aColor ?? UIColor.black])
    }
    
    /// Used to add an image to a NSAttributedString as a NSAttachment.
    ///
    /// - Parameter anImage: The image you want to add to the NSAttributedString.
    /// - Returns: The NSAttributedString with the image.
    func getStringWith(anImage: UIImage)->NSAttributedString {
        
        let strToReturn = NSMutableAttributedString(string: String())
        let imgAttachment = NSTextAttachment()
        var image = anImage
        image = image.resize(targetSize: CGSize(width: 20, height: 20))
        imgAttachment.image = image
        let imgString = NSAttributedString(attachment: imgAttachment)
        strToReturn.append(imgString)
        strToReturn.append(NSAttributedString(string: " " + self, attributes: [:]))
        return strToReturn
    }
}
