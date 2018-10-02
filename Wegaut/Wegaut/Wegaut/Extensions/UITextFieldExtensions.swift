//
//  UITextFieldExtensions.swift
//  ISAP
//
//  Created by Felipe Ortega on 1/31/18.
//  Copyright © 2018 Praxis. All rights reserved.
//

import UIKit

extension UITextField{
    
    /// Used to set/remove an invalid input state for an specific textfield.
    ///
    /// - Parameter addImage: If it's false is a valid parameter.
    func showInvalidInputStateWhen(isValidInput:Bool){
        
        let rightImageView:UIImageView = UIImageView(image: #imageLiteral(resourceName: "ICError"))
        rightImageView.image = rightImageView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        rightImageView.tintColor = UIColor.red
        rightImageView.frame =  CGRect(x: 0,
                                       y: 0,
                                       width: (rightImageView.image?.size.width)!+20,
                                       height: (rightImageView.image?.size.height)!+20)
        rightImageView.contentMode = UIView.ContentMode.center
        self.rightView = isValidInput ? rightImageView : nil
        self.rightViewMode = UITextField.ViewMode.always
        var attribute = NSAttributedString(string: self.text!,
                                           attributes : [NSAttributedString.Key.foregroundColor:isValidInput ? UIColor.red : UIColor.lightGray])
        self.attributedText = attribute
        if let placeholder = self.placeholder{
            attribute = NSAttributedString(string: placeholder,
                                           attributes:[NSAttributedString.Key.foregroundColor : isValidInput ? UIColor.red : UIColor.lightGray])
            self.attributedPlaceholder = attribute
        }
    }
    
    /// Used to add left image in a UITextfield
    ///
    /// - Parameters:
    ///   - image: UIImage to be used.
    ///   - paddingUpDown: CGFLoat divided between two to assure centered image.
    ///   - paddingLeftRight: CGFLoat divided between two to assure centered image.
    func addLeftImageWith(image:UIImage?, paddingUpDown:CGFloat?, paddingLeftRight:CGFloat?){
        
        if let anImage = image{
            let leftImageView:UIImageView = UIImageView(image: anImage)
            leftImageView.frame =  CGRect(x: 0,
                                          y: 0,
                                          width: (leftImageView.image?.size.width)!+(paddingLeftRight ?? 20),
                                          height: (leftImageView.image?.size.height)!+(paddingUpDown ?? 10))
            leftImageView.contentMode = UIView.ContentMode.center
            self.leftView = leftImageView
            self.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    /// Used to add left image in a UITextfield with an specific tintColor
    ///
    /// - Parameters:
    ///   - image: UIImage to be used.
    ///   - withTintColor: UIColor to assign.
    ///   - paddingUpDown: CGFLoat divided between two to assure centered image.
    ///   - paddingLeftRight: CGFLoat divided between two to assure centered image.
    func addLeftImageWith(image:UIImage?, tintColor:UIColor?, paddingUpDown:CGFloat?, paddingLeftRight:CGFloat?){
        
        if let anImage = image{
            let imageToColor:UIImage = anImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            let leftImageView:UIImageView = UIImageView(image: imageToColor)
            if let aTintColor = tintColor{
                leftImageView.tintColor = aTintColor
            }else{
                leftImageView.tintColor = UIColor.clear
            }
            leftImageView.frame =  CGRect(x: 0,
                                          y: 0,
                                          width: (leftImageView.image?.size.width)!+(paddingLeftRight ?? 20),
                                          height: (leftImageView.image?.size.height)!+(paddingUpDown ?? 10))
            leftImageView.contentMode = UIView.ContentMode.center
            self.leftView = leftImageView
            self.leftViewMode = UITextField.ViewMode.always
        }
    }
    
    /// Used to add left image in a UITextfield
    ///
    /// - Parameters:
    ///   - image: UIImage to be used.
    ///   - paddingUpDown: CGFLoat divided between two to assure centered image.
    ///   - paddingLeftRight: CGFLoat divided between two to assure centered image.
    func addRightImageWith(image:UIImage?, paddingUpDown:CGFloat?, paddingLeftRight:CGFloat?){
        
        if let anImage = image{
            let rightImageView:UIImageView = UIImageView(image: anImage)
            rightImageView.frame =  CGRect(x: 0,
                                          y: 0,
                                          width: (rightImageView.image?.size.width)!+(paddingLeftRight ?? 20),
                                          height: (rightImageView.image?.size.height)!+(paddingUpDown ?? 10))
            rightImageView.contentMode = UIView.ContentMode.center
            self.rightView = rightImageView
            self.rightViewMode = UITextField.ViewMode.always
        }
    }
    
    /// Used to add left image in a UITextfield with an specific tintColor
    ///
    /// - Parameters:
    ///   - image: UIImage to be used.
    ///   - withTintColor: UIColor to assign.
    ///   - paddingUpDown: CGFLoat divided between two to assure centered image.
    ///   - paddingLeftRight: CGFLoat divided between two to assure centered image.
    func addRightImageWith(image:UIImage?, tintColor:UIColor?, paddingUpDown:CGFloat?, paddingLeftRight:CGFloat?){
        
        if let anImage = image{
            let imageToColor:UIImage = anImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            let rightImageView:UIImageView = UIImageView(image: imageToColor)
            if let aTintColor = tintColor{
                rightImageView.tintColor = aTintColor
            }else{
                rightImageView.tintColor = UIColor.clear
            }
            rightImageView.frame =  CGRect(x: 0,
                                          y: 0,
                                          width: (rightImageView.image?.size.width)!+(paddingLeftRight ?? 20),
                                          height: (rightImageView.image?.size.height)!+(paddingUpDown ?? 10))
            rightImageView.contentMode = UIView.ContentMode.center
            self.rightView = rightImageView
            self.rightViewMode = UITextField.ViewMode.always
        }
    }
    
    /// Used to set a UIReturnKeyType next or done to a UItextfield.
    ///
    /// - Parameter isNext: If the value it's TRUE the UIReturnKeyType will be next; otherwise it'll be done.
    func setReturnType(isNext:Bool){
        
        self.returnKeyType = isNext ? UIReturnKeyType.next:UIReturnKeyType.done
    }
}
