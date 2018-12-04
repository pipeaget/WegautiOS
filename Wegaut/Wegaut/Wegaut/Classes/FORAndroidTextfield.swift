//
//  FORAndroidTextfield.swift
//  FORTextfield
//
//  Created by Felipe Ortega on 6/14/18.
//  Copyright © 2018 CIGrupo. All rights reserved.
//

import UIKit

@IBDesignable class FORAndroidTextfield: UIControl {
    
    //MARK: - OUTLETS
    
    /// A UILabel used to display the placeholder while editing the tfInput.
    var lblPlaceholder: UILabel!
    
    /// A UITextField used to contain a String value.
    var tfInput: UITextField!
    
    /// A UIView used to show a separator/divider ornament between the tfInput and the end of the FORAndroidTextfield.
    var vwDivider: UIView!

    //MARK: - VWCONTAINER PROPERTIES
    
    /// An UIColor value used to specify the toolTintColor of the toolbar textfield accesory while editing the tfInput (The method addToolBarToKeyboard must be added in the textFieldDidBeginEditing UITextFieldDelegate).
    @IBInspectable var toolBarTintColor: UIColor = UIColor.white
    
    /// An UIColor value used to specify the tintColor of the toolbar textfield accesory while editing the tfInput (The method addToolBarToKeyboard must be added in the textFieldDidBeginEditing UITextFieldDelegate).
    @IBInspectable var toolTintColor: UIColor = UIColor.black
    
    /// An UIColor value used to specify the text of the button inside the toolbar textfield accesory while editing the tfInput (The method addToolBarToKeyboard must be added in the textFieldDidBeginEditing UITextFieldDelegate).
    @IBInspectable var toolBarButtonText: String = "OK"
    
    /// A UIColor value that specifies the background color of the container view.
    @IBInspectable var containerBackgroundColor: UIColor = UIColor.white{
        didSet{
            backgroundColor = containerBackgroundColor
        }
    }
    
    //MARK: - LBLPLACEHOLDER PROPERTIES
    
    /// An UIColor value that specifies the text color for the lblPlaceholder.
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray{
        didSet{
            lblPlaceholder.textColor = placeholderColor
        }
    }
    
    /// An UIFont value that specifies the placeholder font for the lblPlaceholder.
    @IBInspectable var placeholderFont: UIFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular){
        didSet{
            lblPlaceholder.font = placeholderFont
        }
    }
    
    /// A String value that specifies the placeholder text for the lblPlaceholder.
    @IBInspectable var strPlaceholder: String = ""{
        didSet{
            lblPlaceholder.text = strPlaceholder
        }
    }
    
    //MARK: - TFINPUT PROPERTIES
    
    /// An UIColor value that specifies the text color for the tfInput.
    @IBInspectable var textFieldTextColor: UIColor = UIColor.black{
        didSet{
            tfInput.textColor = textFieldTextColor
        }
    }
    
    /// An UIFont value that specifies the placeholder font for the tfInput.
    @IBInspectable var textFieldFont: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium){
        didSet{
            tfInput.font = textFieldFont
        }
    }
    
    /// An optional UIImage value that specifies an image to be setted at the right view of the tfInput.
    @IBInspectable var rightTextFieldImage: UIImage?{
        didSet{
            drawControl()
        }
    }
    
    /// An optional UIColor value that specifies the color for an image to be setted at the right view of the tfInput.
    @IBInspectable var rightTextFieldImageTintColor: UIColor?{
        didSet{
            drawControl()
        }
    }
    
    /// An optional UIImage value that specifies an image to be setted at the left view of the tfInput.
    @IBInspectable var leftTextFieldImage: UIImage?{
        didSet{
            drawControl()
        }
    }
    
    /// An optional UIColor value that specifies the color for an image to be setted at the left view of the tfInput.
    @IBInspectable var leftTextFieldImageTintColor: UIColor?{
        didSet{
            drawControl()
        }
    }
    
    /// An UIColor value that specifies the background color for the vwDivider.
    @IBInspectable var dividerColor: UIColor = UIColor.darkGray{
        didSet{
            vwDivider.backgroundColor = dividerColor
            drawControl()
        }
    }
    
    //MARK: - INITIALIZERS
    
    /// Used to initialize the FORAndroidTextfield.
    ///
    /// - Parameter frame: The corresponding CGRect for the UIControl (At least 50 pixels of height and 100 of width).
    override init(frame: CGRect){
        
        super.init(frame: frame)
        drawControl()
    }
    
    /// Used to optionally initialize the FORAndroidTextfield.
    ///
    /// - Parameter coder: The corresponding NSCoder.
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        drawControl()
    }
    
    //MARK: - FUNCTIONS
    
    /// Used to draw all the corresponding outlets according to FORAndroidTextfield values.
    func drawControl(){
        
        subviews.forEach{$0.removeFromSuperview()}
        
        let controlSize: CGSize = bounds.size
        var originY: CGFloat = 0
        
        lblPlaceholder = UILabel(frame: CGRect(x: 0,
                                               y: originY,
                                               width: controlSize.width,
                                               height: controlSize.height * 0.35))
        lblPlaceholder.textColor = placeholderColor
        lblPlaceholder.font = placeholderFont
        if  let textField = tfInput,
            let tfInputText = textField.text{
            
            lblPlaceholder.text = tfInputText.count > 0 ? strPlaceholder : ""
        }else{
            
            lblPlaceholder.text = ""
        }
        
        addSubview(lblPlaceholder)
        originY += lblPlaceholder.frame.height
        
        
        tfInput = UITextField(frame: CGRect(x: 0,
                                            y: originY,
                                            width: controlSize.width,
                                            height: controlSize.height * 0.425))
        
        if let imgLeft = rightTextFieldImage{
            tfInput.addLeftImageWith(image: imgLeft,
                                     tintColor: leftTextFieldImageTintColor)
        }
        
        if let imgRight = leftTextFieldImage{
            tfInput.addRightImageWith(image: imgRight,
                                      tintColor: leftTextFieldImageTintColor)
        }
        
        if let tfInputText = tfInput.text{
            
            tfInput.placeholder = tfInputText.count > 0 ? "" : strPlaceholder
        }else{
            
            tfInput.text = strPlaceholder
        }
        addSubview(tfInput)
        originY += tfInput.frame.height + (controlSize.height * 0.2)
        
        vwDivider = UIView(frame: CGRect(x: 0,
                                         y: originY,
                                         width: controlSize.width,
                                         height: controlSize.height * 0.025))
        vwDivider.backgroundColor = dividerColor
        addSubview(vwDivider)
        originY += vwDivider.frame.height
    }
    
    /// Used to set the FORAndroidTextfield corresponding User Interface while editing tfInput (This method must be added in the textFieldDidBeginEditing UITextFieldDelegate).
    func activePlaceholder(){
        
        lblPlaceholder.alpha = 0
        UIView.animate(withDuration: 0.5) {
            
            self.tfInput.placeholder = ""
            self.lblPlaceholder.alpha = 1
            self.lblPlaceholder.text = self.strPlaceholder
        }
    }
    
    /// Used to set the FORAndroidTextfield corresponding User Interface while not editing tfInput This method must be added in the textFieldDidEndEditing UITextFieldDelegate).
    func deactivatePlaceholder(){
        
        if tfInput.text!.count == 0{
            
            self.tfInput.alpha = 0
        }
        
        UIView.animate(withDuration: 0.5) {
        
            self.tfInput.alpha = 1
            self.tfInput.placeholder = self.tfInput.text!.count > 0 ? "" : self.strPlaceholder
            self.lblPlaceholder.text = self.tfInput.text!.count > 0 ? self.strPlaceholder : ""
        }
    }
    
    /// Used to dismiss the keyboard from the current view.
    @objc func hideKeyboard(){
        
        self.endEditing(true)
    }
    
    /// Used to add a UIToolbar to the tfInput while editing (This method must be added in the textFieldDidBeginEditing UITextFieldDelegate).
    func addToolBarToKeyboard(){
        
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        let flexibleSpace:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: toolBarButtonText, style: UIBarButtonItem.Style.done, target: self, action: #selector(self.hideKeyboard))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.barTintColor = toolBarTintColor
        toolBar.tintColor = toolTintColor
        tfInput.inputAccessoryView = toolBar
    }
    
}

extension UITextField{
    
    /// Used to add left image with tintColor (optional) in a UITextfield class or child.
    ///
    /// - Parameters:
    ///   - imageName: The UIImage value to be assigned.
    ///   - tintColor: The UIColor value for the image.
    func addLeftImageWith(image: UIImage, tintColor: UIColor?){
        
        let imgResizable: UIImage = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let imgvwLeft: UIImageView = UIImageView(image: imgResizable)
        imgvwLeft.frame = CGRect(x: 0,
                                 y: 0,
                                 width: 30,
                                 height: 30)
        imgvwLeft.contentMode = UIView.ContentMode.scaleAspectFit
        imgvwLeft.tintColor = tintColor ?? UIColor.white
        self.leftView = imgvwLeft
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    /// Used to add right image with tintColor (optional) in a UITextfield class or child.
    ///
    /// - Parameters:
    ///   - imageName: The UIImage value to be assigned.
    ///   - tintColor: The UIColor value for the image.
    func addRightImageWith(image: UIImage, tintColor: UIColor?){
        
        let imgResizable: UIImage = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        let imgvwRight: UIImageView = UIImageView(image: imgResizable)
        imgvwRight.frame = CGRect(x: 0,
                                 y: 0,
                                 width: 30,
                                 height: 30)
        imgvwRight.contentMode = UIView.ContentMode.scaleAspectFit
        imgvwRight.tintColor = tintColor ?? UIColor.white
        self.rightView = imgvwRight
        self.rightViewMode = UITextField.ViewMode.always
    }
}
