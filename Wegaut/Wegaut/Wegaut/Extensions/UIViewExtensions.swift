//
//  UIViewExtensions.swift
//  ISAP
//
//  Created by Felipe Ortega on 1/31/18.
//  Copyright © 2018 Praxis. All rights reserved.
//

import UIKit

extension UIView{
    
    /// Add corner radius to a selected UIView object or child.
    ///
    /// - Parameter cornerRadius: If don't send cornerRadius parameter turns UIView to circular form. (Must be a perfect square to make a perfect circle)
    func cornerRadius(cornerRadius:CGFloat?){
        
        self.layer.cornerRadius = cornerRadius ?? self.frame.height/2
        self.layer.masksToBounds = true
    }
    
    /// Makes an animation that "shakes" the UIView or one of it's childs.
    ///
    /// - Parameters:
    ///   - count: Number of times the view will shake.
    ///   - duration: Timer interval in which all the shakes will be performed.
    ///   - translation: Float
    func shake(count:Float?, duration:TimeInterval?, translation:Float?){
        
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count ?? 5
        animation.duration = duration ?? 0.1
        animation.autoreverses = true
        animation.byValue = translation ?? 10
        layer.add(animation, forKey: "shake")
    }
    
    /// Used to dismiss the keyboard and restore first responder to the UIViewController.
    @objc func dismissKeyboard(){
        self.endEditing(true)
    }
    
    /// Used to obtain the corresponding parent UIViewController.
    var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController?
            }
        }
        return nil
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
