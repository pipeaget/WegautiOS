//
//  FORSelectionButton.swift
//  test
//
//  Created by Felipe Ortega on 7/30/18.
//  Copyright © 2018 Felipe Ortega. All rights reserved.
//

import UIKit

protocol FORSelectionButtonDelegate {
    
    func didChangeSelectionStatus(_ sender: FORSelectionButton)
    func didTextTapped(_ sender: FORSelectionButton)
}

@IBDesignable class FORSelectionButton: UIView {
    
    //MARK: - INSPECTABLE VARIABLES
    
    @IBInspectable var isActive: Bool = false {
        didSet {
            updateView()
            delegate?.didChangeSelectionStatus(self)
        }
    }
    
    @IBInspectable var displayText: String = "Active" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var activeImage: UIImage?{
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var activeTintColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var activeTextColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var activeFont: UIFont = UIFont.systemFont(ofSize: 16,
                                                                weight: UIFont.Weight.regular) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var unactiveImage: UIImage?{
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var unactiveTintColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var unactiveTextColor: UIColor = UIColor.lightText {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var unactiveFont: UIFont = UIFont.systemFont(ofSize: 16,
                                                                weight: UIFont.Weight.light) {
        didSet {
            updateView()
        }
    }
    
    //MARK: - VARIABLES
    
    var delegate: FORSelectionButtonDelegate?
    
    //MARK: - OUTLETS
    
    var btnSelection: UIButton!
    var btnText: UIButton!

    //MARK: - VIEW LIFECYCLE
    
    override func draw(_ rect: CGRect) {
        
        updateView()
    }
    
    //MARK: - FUNCTIONS

    func updateView() {
        
        self.subviews.forEach{$0.removeFromSuperview()}
        
        let viewWidth: CGFloat = self.frame.width
        self.backgroundColor = UIColor.clear
        
        btnSelection = UIButton(frame: CGRect(x: 10,
                                              y: 10,
                                              width: 50,
                                              height: 50))
        
        if  let imgActive: UIImage = activeImage,
            let imgUnactive = unactiveImage {
            
            let imgToDisplay: UIImage = isActive ? imgActive : imgUnactive
            imgToDisplay.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            btnSelection.setImage(imgToDisplay, for: UIControl.State.normal)
        } else {
            
            btnSelection.setImage(UIImage(), for: UIControl.State.normal)
        }
        
        btnSelection.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        btnSelection.imageView?.tintColor = isActive ? activeTintColor : unactiveTintColor
        btnSelection.addTarget(self, action: #selector(self.tapButton), for: UIControl.Event.touchUpInside)
        addSubview(btnSelection)
        
        btnText = UIButton(frame: CGRect(x: 64,
                                         y: 8,
                                         width: viewWidth - (btnSelection.frame.width + 24),
                                         height: self.frame.height - 16))
        btnText.titleLabel?.font = isActive ? activeFont : unactiveFont
        btnText.setTitleColor(isActive ? activeTextColor : unactiveTextColor, for: UIControl.State.normal)
        btnText.setTitle(displayText, for: UIControl.State.normal)
        btnText.titleLabel?.adjustsFontSizeToFitWidth = true
        btnText.addTarget(self, action: #selector(self.tapText), for: UIControl.Event.touchUpInside)
        addSubview(btnText)
    }
    
    @objc func tapButton() {
        
        isActive = !isActive
    }
    
    @objc func tapText() {
        delegate?.didTextTapped(self)
    }
}
