//
//  FORPopUpView.swift
//  Aeneas
//
//  Created by Felipe Ortega on 1/10/18.
//  Copyright © 2018 Felipe Ortega. All rights reserved.
//

import UIKit

//MARK: - POPUP PROTOCOL DEFINITION

protocol ModalPopUp {
    
    //MARK: OUTLETS
    
    var vwBackground: UIView {get}
    var vwDialog: UIView {get set}
    
    //MARK: FUNCTIONS
    
    func show(animated:Bool)
    func dismiss(animated:Bool)
}

//MARK: - POTOCOL EXTENSIONS

extension ModalPopUp where Self: UIView{
    
    /// Used to display the FORPopUpView it can be displayed with or without an animation.
    ///
    /// - Parameter animated: This value is a BOOL type. If it's true it displays the popup with an animation; otherwise it's display isnt't animated.
    func show(animated:Bool){
        
        self.vwBackground.alpha = 0
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            
            while let presentedViewController = topController.presentedViewController {
                
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        if animated {
            
            UIView.animate(withDuration: 0.5,
                           animations: {
                            
                            self.vwBackground.alpha = 0.66
            })
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 5,
                           options: UIView.AnimationOptions(rawValue: 0),
                           animations: {
                            
                            self.vwDialog.center  = self.center
            },
                           completion: { (completed) in})
        }else{
            
            self.vwBackground.alpha = 0.66
            self.vwDialog.center  = self.center
        }
    }
    
    /// Used to remove the FORPopUpView from superview it can be displayed with or without an animation.
    ///
    /// - Parameter animated: This value is a BOOL type. If it's true it removes the popup with an animation; otherwise it's remove isnt't animated.
    func dismiss(animated:Bool){
        
        if animated {
            
            UIView.animate(withDuration: 0.5,
                           animations: {
                            
                            self.vwBackground.alpha = 0
            },
                           completion: { (completed) in})
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 5,
                           options: UIView.AnimationOptions(rawValue: 0),
                           animations: {
                            
                            self.vwDialog.center = CGPoint(x: self.center.x,
                                                           y: self.frame.height + self.vwDialog.frame.height/2)
            },
                           completion: { (completed) in
                            
                            self.removeFromSuperview()
            })
        }else{
            
            self.removeFromSuperview()
        }
    }
}

//MARK: - FORAlertTypes

enum FORPopAlertType{
    
    case loginAlert
    case forgotPasswordAlert
    case pickerAlert
    case datePickerAlert
    case yesNoAlert
    case okAlert
}

//MARK: - FORAlertData

class FORAlertData: NSObject{
    
    //MARK: VARIABLES
    
    var popAlertType: FORPopAlertType
    var popTitle: String
    var popBackgroundColor: UIColor?
    var popMessage: String?
    var tfEmail: UITextField?
    var tfPassword: UITextField?
    var popOkButtonText: String?
    var popOKButtonColor: UIColor?
    var popYesButtonText: String?
    var popYesButtonColor: UIColor?
    var popNoButtonText: String?
    var popNoButtonColor: UIColor?
    var popSelectOptions: [String]?
    
    //MARK: LOGIN INITIALIZERS
    
    /// Used to initialize a FORPopUpView with a UI for login.
    ///
    /// - Parameters:
    ///   - backgroundColor: An optional background color of the dialog view. (Default is white)
    ///   - aTitle: The title for the FORPopUpView. (REQUIRED)
    ///   - aMessage: An optional message for the FORPopUpView. (Default is empty)
    ///   - loginButtonTitle: An optional text for the LOGIN Button. (Default is OK)
    ///   - loginButtonColor: An optional background color for the LOGIN Button. (Default is White)
    init(login backgroundColor: UIColor?, aTitle: String, aMessage: String?, loginButtonTitle: String?, loginButtonColor: UIColor?){
        
        //REQUIRED VALUES
        
        self.popAlertType = FORPopAlertType.loginAlert
        self.popTitle = aTitle
        
        //OPTIONAL VALUES
        
        self.popBackgroundColor = backgroundColor ?? UIColor.white
        self.popMessage = aMessage ?? ""
        self.popOkButtonText = loginButtonTitle ?? "LOG_LOG".localized
        self.popOKButtonColor = loginButtonColor ?? UIColor.white
        
        //NOT REQUIRED VALUES
        
        self.popYesButtonText = nil
        self.popYesButtonColor = nil
        self.popNoButtonText = nil
        self.popNoButtonColor = nil
        self.popSelectOptions = nil
    }
    
    //MARK: FORGOTPASSWORD INITIALIZERS
    
    /// Used to initialize a FORPopUpView with a UI for recovering a password.
    ///
    /// - Parameters:
    ///   - backgroundColor: An optional background color of the dialog view. (Default is white)
    ///   - aTitle: The title for the FORPopUpView. (REQUIRED)
    ///   - aMessage: An optional message for the FORPopUpView. (Default is empty)
    ///   - okButtonTitle: An optional text for the OK Button. (Default is OK)
    ///   - okButtonColor: An optional background color for the OK Button. (Default is White)
    init(forgotPassword backgroundColor: UIColor?, aTitle: String, aMessage: String?, okButtonTitle: String?, okButtonColor: UIColor?){
        
        //REQUIRED VALUES
        
        self.popAlertType = FORPopAlertType.forgotPasswordAlert
        self.popTitle = aTitle
        
        //OPTIONAL VALUES
        
        self.popBackgroundColor = backgroundColor ?? UIColor.white
        self.popMessage = aMessage ?? ""
        self.popOkButtonText = okButtonTitle ?? "Aceptar"
        self.popOKButtonColor = okButtonColor ?? UIColor.white
        
        //NOT REQUIRED VALUES
        
        self.popYesButtonText = nil
        self.popYesButtonColor = nil
        self.popNoButtonText = nil
        self.popNoButtonColor = nil
        self.popSelectOptions = nil
    }
    
    //MARK: FILTEROPTIONS INITIALIZER
    
    /// Used to initialize a FORPopUpView with a UI for displaying filter options.
    ///
    /// - Parameters:
    ///   - backgroundColor: An optional background color of the dialog view. (Default is white)
    ///   - aTitle: The title for the FORPopUpView. (REQUIRED)
    ///   - aMessage: An optional message for the FORPopUpView. (Default is empty)
    ///   - yesButtonTitle: An optional title for the Yes Button. (Default is YES)
    ///   - yesButtonColor: An optional background color for the Yes Button. (Default is BLUE)
    ///   - noButtonTitle: An optional title for the No Button. (Default is NO)
    ///   - noButtonColor: An optional background color for the No Button. (Default is RED)
    ///   - selectOptions: An optional array of strings that will be displayed as selectable rows in a picker.
    init(filterOptions backgroundColor:UIColor?, aTitle: String, aMessage:String?, yesButtonTitle:String?, yesButtonColor:UIColor?, noButtonTitle:String?, noButtonColor:UIColor?, selectOptions:[String]){
        
        //REQUIRED VALUES
        
        self.popAlertType = FORPopAlertType.pickerAlert
        self.popTitle = aTitle
        
        //OPTIONAL VALUES
        
        self.popBackgroundColor = backgroundColor ?? UIColor.white
        self.popMessage = aMessage ?? ""
        self.popYesButtonText = yesButtonTitle ?? "Aceptar"
        self.popYesButtonColor = yesButtonColor ?? UIColor.deepPurple
        self.popNoButtonText = noButtonTitle ?? "NO"
        self.popNoButtonColor = noButtonColor ?? UIColor.deepPurple
        self.popSelectOptions = selectOptions
        
        //NOT REQUIRED VALUES
        
        self.popOkButtonText = nil
        self.popOKButtonColor = nil
    }
    
    init(datePicker backgroundColor:UIColor?, aTitle: String, aMessage:String?, yesButtonTitle:String?, yesButtonColor:UIColor?, noButtonTitle:String?, noButtonColor:UIColor?){
        
        //REQUIRED VALUES
        
        self.popAlertType = FORPopAlertType.datePickerAlert
        self.popTitle = aTitle
        
        //OPTIONAL VALUES
        
        self.popBackgroundColor = backgroundColor ?? UIColor.white
        self.popMessage = aMessage ?? ""
        self.popYesButtonText = yesButtonTitle ?? "Aceptar"
        self.popYesButtonColor = yesButtonColor ?? UIColor.deepPurple
        self.popNoButtonText = noButtonTitle ?? "NO"
        self.popNoButtonColor = noButtonColor ?? UIColor.deepPurple
        
        //NOT REQUIRED VALUES
        
        self.popOkButtonText = nil
        self.popOKButtonColor = nil
        self.popSelectOptions = nil
    }
    
    /// Used to initialize a FORPopUpView with a UI for displaying filter options.
    ///
    /// - Parameters:
    ///   - yesNoAlertBackgroundColor: An optional background color of the dialog view. (Default is white)
    ///   - aTitle: The title for the FORPopUpView. (REQUIRED)
    ///   - aMessage: An optional message for the FORPopUpView. (Default is empty)
    ///   - yesButtonTitle: An optional title for the Yes Button. (Default is Yes)
    ///   - yesButtonColor: An optional backgroundcolor for the Yes Button. (Default is White)
    ///   - noButtonTitle: An optional title for the No Button. (Default is No)
    ///   - noButtonColor: An optional backgroundcolor for the No Button. (Default is White)
    init(yesNoAlert backgroundColor:UIColor?, aTitle: String, aMessage:String?, yesButtonTitle:String?, yesButtonColor:UIColor?, noButtonTitle:String?, noButtonColor:UIColor?){
        
        //REQUIRED VALUES
        
        self.popAlertType = FORPopAlertType.yesNoAlert
        self.popTitle = aTitle
        
        //OPTIONAL VALUES
        
        self.popBackgroundColor = backgroundColor ?? UIColor.white
        self.popMessage = aMessage ?? ""
        self.popYesButtonText = yesButtonTitle
        self.popYesButtonColor = yesButtonColor
        self.popNoButtonText = noButtonTitle
        self.popNoButtonColor = noButtonColor
        
        //NOT REQUIRED VALUES
        
        self.popSelectOptions = nil
        self.popOkButtonText = nil
        self.popOKButtonColor = nil
    }
    
    //MARK: OKALERT INITIALIZERS
    
    /// Used to initialize a FORPopUpView with a UI for displaying a generic OK Alert.
    ///
    /// - Parameters:
    ///   - okAlertBackgroundColor: An optional background color of the dialog view. (Default is white)
    ///   - aTitle: The title for the FORPopUpView. (REQUIRED)
    ///   - aMessage: An optional message for the FORPopUpView. (Default is empty)
    ///   - okButtonTitle: An optional title for the Ok Button. (Default is OK)
    ///   - okButtonColor: An optional backgroundcolor for the Ok Button. (Default is White)
    init(okAlert backgroundColor:UIColor?, aTitle: String, aMessage:String?, okButtonTitle:String?, okButtonColor:UIColor?){
        
        //REQUIRED VALUES
        
        self.popAlertType = FORPopAlertType.okAlert
        self.popTitle = aTitle
        
        //OPTIONAL VALUES
        
        self.popBackgroundColor = backgroundColor ?? UIColor.white
        self.popMessage = aMessage ?? ""
        self.popOkButtonText = okButtonTitle ?? "Aceptar"
        self.popOKButtonColor = okButtonColor ?? UIColor.white
        
        //NOT REQUIRED VALUES
        
        self.popYesButtonText = nil
        self.popYesButtonColor = nil
        self.popNoButtonText = nil
        self.popNoButtonColor = nil
        self.popSelectOptions = nil
    }
}

//MARK: - FORTypeAlias

/// Used to return a Bool value obtained from a YES(True) / NO(False) alert.
typealias YesNoAction = (Bool)->Void

/// Used to obtain the corresponding row index selected by the user from a Filter Option alert.
typealias SelectionAction = (Int)->Void

/// Used to obtain the corresponding date selected by the user from a Date Selection alert.
typealias DateSelectionAction = (Date)->Void

/// Used to obtain the corresponding option selected by the user from a Selection alert.
typealias OptionSelectionAction = (String)->Void

//MARK: - FORAlertUIConstructor

class FORPopUpView: UIView, ModalPopUp {
    
    //MARK: VARIABLES
    
    var popAlertData: FORAlertData!
    var activeTextField: UITextField?
    var arrTextFields: [UITextField]!
    var selectedSegmentIndex: Int?
    var arrSelectOptions: [String]!
    var dateSelected: Date?
    var tfToValidate: UITextField?
    var loginSuccess: YesNoAction?
    var forgotPasswordSuccess: YesNoAction?
    var yesNoSuccess: YesNoAction?
    var dateSelection: DateSelectionAction?
    var pickerSelection: OptionSelectionAction?

    //MARK: OUTLETS
    
    var vwBackground: UIView = UIView()
    var vwDialog: UIView = UIView()
    
    //MARK: INITIALIZERS
    
    /// Used to build/initialize a FORPopUpView with it's corresponding FORAlertData.
    ///
    /// - Parameter aPopAlertData: a FORAlertData that contains the corresponding values according to the FORPopAlertType.
    convenience init(with aPopAlertData: FORAlertData){
        
        self.init(frame: UIScreen.main.bounds)
        self.popAlertData = aPopAlertData
        self.arrTextFields = []
        self.arrSelectOptions = []
        
        switch self.popAlertData.popAlertType {
            
        case FORPopAlertType.loginAlert:
            drawLoginAlertUI(anImage: #imageLiteral(resourceName: "ICWarning"))
            
        case FORPopAlertType.forgotPasswordAlert:
            drawForgotPasswordUI(anImage: #imageLiteral(resourceName: "ICWarning"))
        
        case FORPopAlertType.pickerAlert:
            self.selectedSegmentIndex = 0
            self.arrSelectOptions = aPopAlertData.popSelectOptions
            drawSelectionAlert(anOptionsArray: arrSelectOptions)
            
        case FORPopAlertType.datePickerAlert:
            dateSelected = Date()
            drawDateAlert()
            
        case FORPopAlertType.yesNoAlert:
            drawYesNoAlert(anImage: nil)
            
        default:
            drawOKAlert()
        }
    }
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder:NSCoder) {
        
        fatalError("Init(coder:) has not been implemented")
    }
    
    //MARK: FUNCTIONS
    
    func drawLoginAlertUI(anImage: UIImage?){
        
        let dialogWidth: CGFloat = frame.size.width - 60
        var originY: CGFloat = 10
        
        vwDialog.clipsToBounds = true
        
        vwBackground.frame = frame
        vwBackground.backgroundColor = UIColor.black
        vwBackground.alpha = 0.75
        vwBackground.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(didTappedOnvwBackground)))
        self.addSubview(vwBackground)
        
        if let alertImage = anImage{
            let imgAlert:UIImageView = UIImageView(frame: CGRect(x: (dialogWidth / 2) - 25,
                                                                 y: originY,
                                                                 width: 50,
                                                                 height: 50))
            imgAlert.image = alertImage
            imgAlert.contentMode = UIView.ContentMode.scaleAspectFit
            vwDialog.addSubview(imgAlert)
            originY += imgAlert.frame.height + 15
        }
        
        let lblTitle: UILabel = UILabel(frame: CGRect(x: 10,
                                                      y: originY,
                                                      width: dialogWidth - 20,
                                                      height: getContainerHeight(accordingTo: self.popAlertData.popTitle,
                                                                                 aFont: UIFont.systemFont(ofSize: 14),
                                                                                 containerWidth: dialogWidth - 20) + CGFloat(10)))
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.text = self.popAlertData.popTitle
        vwDialog.addSubview(lblTitle)
        originY += lblTitle.frame.height + 8
        
        if self.popAlertData.popMessage != nil && self.popAlertData.popMessage != ""{
            let lblMessage:UILabel = UILabel(frame: CGRect(x: 10,
                                                           y: originY,
                                                           width: dialogWidth - 20,
                                                           height: getContainerHeight(accordingTo: self.popAlertData.popMessage ?? "",
                                                                                      aFont: UIFont.systemFont(ofSize: 14),
                                                                                      containerWidth: dialogWidth - 40) + CGFloat(10)))
            lblMessage.font = UIFont.systemFont(ofSize: 14)
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.text = self.popAlertData.popMessage
            lblMessage.numberOfLines = 0
            vwDialog.addSubview(lblMessage)
            originY += lblMessage.frame.height + 8
        }
        
        let tfEmail: UITextField = UITextField(frame: CGRect(x: 10,
                                                             y: originY,
                                                             width: dialogWidth - 20,
                                                             height: 30))
        tfEmail.placeholder = "Correo electrónico"
        tfEmail.borderStyle = UITextField.BorderStyle.roundedRect
        tfEmail.keyboardType = UIKeyboardType.emailAddress
        tfEmail.autocapitalizationType = UITextAutocapitalizationType.none
        tfEmail.autocorrectionType = UITextAutocorrectionType.no
        tfEmail.setReturnType(isNext: false)
        tfEmail.delegate = self
        self.arrTextFields.append(tfEmail)
        vwDialog.addSubview(tfEmail)
        originY += tfEmail.frame.height + 15
        
        let tfPassword: UITextField = UITextField(frame: CGRect(x: 10,
                                                             y: originY,
                                                             width: dialogWidth - 20,
                                                             height: 30))
        tfPassword.placeholder = "Contraseña"
        tfPassword.borderStyle = UITextField.BorderStyle.roundedRect
        tfPassword.keyboardType = UIKeyboardType.emailAddress
        tfPassword.autocapitalizationType = UITextAutocapitalizationType.none
        tfPassword.autocorrectionType = UITextAutocorrectionType.no
        tfPassword.setReturnType(isNext: false)
        tfPassword.delegate = self
        self.arrTextFields.append(tfPassword)
        vwDialog.addSubview(tfPassword)
        originY += tfPassword.frame.height + 15
        
        let btnLogin: UIButton = UIButton(frame: CGRect(x: (dialogWidth / 2) - 50,
                                                        y: originY,
                                                        width: 100,
                                                        height: 40))
        btnLogin.setTitle("Enviar",
                          for: UIControl.State.normal)
        btnLogin.backgroundColor = UIColor.deepPurple
        btnLogin.setTitleColor(UIColor.white,
                               for: UIControl.State.normal)
        btnLogin.addTarget(self,
                           action: #selector(actLogin),
                           for: UIControl.Event.touchUpInside)
        btnLogin.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnLogin)
        originY += btnLogin.frame.height + 15
        
        vwDialog.frame = CGRect(x: 30,
                                y: frame.height,
                                width: dialogWidth,
                                height: originY)
        vwDialog.backgroundColor = UIColor.white
        vwDialog.cornerRadius(cornerRadius: 5)
        addSubview(vwDialog)
    }
    
    /// Used to draw the Forgot Password outlets and it's functionalities.
    ///
    /// - Parameter anImage: An optional image for the FORPopUp view. (If the image is nil, the view will not draw the image container)
    func drawForgotPasswordUI(anImage: UIImage?){
        
        let dialogWidth: CGFloat = frame.size.width - 60
        var originY: CGFloat = 10
        
        vwDialog.clipsToBounds = true
        
        vwBackground.frame = frame
        vwBackground.backgroundColor = UIColor.black
        vwBackground.alpha = 0.75
        vwBackground.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(didTappedOnvwBackground)))
        self.addSubview(vwBackground)
        
        if let alertImage = anImage{
            let imgAlert:UIImageView = UIImageView(frame: CGRect(x: (dialogWidth / 2) - 25,
                                                                 y: originY,
                                                                 width: 50,
                                                                 height: 50))
            imgAlert.image = alertImage
            imgAlert.contentMode = UIView.ContentMode.scaleAspectFit
            vwDialog.addSubview(imgAlert)
            originY += imgAlert.frame.height + 15
        }
        
        let lblTitle: UILabel = UILabel(frame: CGRect(x: 10,
                                                                                   y: originY,
                                                                                   width: dialogWidth - 20,
                                                                                   height: getContainerHeight(accordingTo: self.popAlertData.popTitle,
                                                                                                                                  aFont: UIFont.systemFont(ofSize: 14),
                                                                                                                                  containerWidth: dialogWidth - 20) + CGFloat(10)))
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.text = self.popAlertData.popTitle
        vwDialog.addSubview(lblTitle)
        originY += lblTitle.frame.height + 8
        
        if self.popAlertData.popMessage != nil && self.popAlertData.popMessage != ""{
            let lblMessage:UILabel = UILabel(frame: CGRect(x: 10,
                                                           y: originY,
                                                           width: dialogWidth - 20,
                                                           height: getContainerHeight(accordingTo: self.popAlertData.popMessage ?? "",
                                                                                      aFont: UIFont.systemFont(ofSize: 14),
                                                                                      containerWidth: dialogWidth - 40) + CGFloat(10)))
            lblMessage.font = UIFont.systemFont(ofSize: 14)
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.text = self.popAlertData.popMessage
            lblMessage.numberOfLines = 0
            vwDialog.addSubview(lblMessage)
            originY += lblMessage.frame.height + 8
        }
        
        let tfEmail: UITextField = UITextField(frame: CGRect(x: 10,
                                                                                                y: originY,
                                                                                                width: dialogWidth - 20,
                                                                                                height: 30))
        tfEmail.placeholder = "Correo electrónico"
        tfEmail.borderStyle = UITextField.BorderStyle.roundedRect
        tfEmail.keyboardType = UIKeyboardType.emailAddress
        tfEmail.autocapitalizationType = UITextAutocapitalizationType.none
        tfEmail.autocorrectionType = UITextAutocorrectionType.no
        tfEmail.setReturnType(isNext: false)
        tfEmail.delegate = self
        self.arrTextFields.append(tfEmail)
        vwDialog.addSubview(tfEmail)
        originY += tfEmail.frame.height + 15
        tfToValidate = tfEmail
        
        let btnLogin: UIButton = UIButton(frame: CGRect(x: (dialogWidth / 2) - 50,
                                                                                          y: originY,
                                                                                          width: 100,
                                                                                          height: 40))
        btnLogin.setTitle("Enviar",
                                     for: UIControl.State.normal)
        btnLogin.backgroundColor = UIColor.deepPurple
        btnLogin.setTitleColor(UIColor.white,
                                              for: UIControl.State.normal)
        btnLogin.addTarget(self,
                           action: #selector(actRecoverPassword),
                                          for: UIControl.Event.touchUpInside)
        btnLogin.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnLogin)
        originY += btnLogin.frame.height + 15
        
        vwDialog.frame = CGRect(x: 30,
                                                    y: frame.height,
                                                    width: dialogWidth,
                                                    height: originY)
        vwDialog.backgroundColor = UIColor.white
        vwDialog.cornerRadius(cornerRadius: 5)
        addSubview(vwDialog)
    }
    
    /// Used to draw the Selection Alert outlets and it's functionalities.
    ///
    /// - Parameter anOptionsArray: The options that the alert should display.
    func drawSelectionAlert(anOptionsArray: [String]){
        
        let dialogWidth: CGFloat = frame.size.width - 60
        var originY: CGFloat = 10
        
        vwDialog.clipsToBounds = true
        
        vwBackground.frame = frame
        vwBackground.backgroundColor = UIColor.black
        vwBackground.alpha = 0.75
        vwBackground.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(didTappedOnvwBackground)))
        self.addSubview(vwBackground)
        
        let lblTitle: UILabel = UILabel(frame: CGRect(x: 10,
                                                     y: originY,
                                                     width: dialogWidth - 20,
                                                     height: getContainerHeight(accordingTo: self.popAlertData.popTitle,
                                                                                aFont: UIFont.systemFont(ofSize: 14),
                                                                                containerWidth: dialogWidth - 20) + CGFloat(10)))
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.text = self.popAlertData.popTitle
        vwDialog.addSubview(lblTitle)
        originY += lblTitle.frame.height + 8
        
        if self.popAlertData.popMessage != nil && self.popAlertData.popMessage != ""{
            let lblMessage:UILabel = UILabel(frame: CGRect(x: 10,
                                                           y: originY,
                                                           width: dialogWidth - 20,
                                                           height: getContainerHeight(accordingTo: self.popAlertData.popMessage ?? "",
                                                                                      aFont: UIFont.systemFont(ofSize: 14),
                                                                                      containerWidth: dialogWidth - 40) + CGFloat(10)))
            lblMessage.font = UIFont.systemFont(ofSize: 14)
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.text = self.popAlertData.popMessage
            lblMessage.numberOfLines = 0
            vwDialog.addSubview(lblMessage)
            originY += lblMessage.frame.height + 8
        }
        
        let pckSelection: UIPickerView = UIPickerView(frame: CGRect(x: 10, y: originY, width: dialogWidth - 20, height: 150))
        pckSelection.numberOfRows(inComponent: self.popAlertData.popSelectOptions!.count)
        pckSelection.dataSource = self
        pckSelection.delegate = self
        pckSelection.reloadAllComponents()
        vwDialog.addSubview(pckSelection)
        originY += pckSelection.frame.height+20
        
        let btnNo: UIButton = UIButton(frame: CGRect(x: 16,
                                                    y: originY,
                                                    width: (dialogWidth / 2) - 24,
                                                    height: 40))
        btnNo.setTitle(self.popAlertData.popNoButtonText,
                       for: UIControl.State.normal)
        btnNo.backgroundColor = self.popAlertData.popNoButtonColor
        btnNo.setTitleColor(UIColor.white,
                            for: UIControl.State.normal)
        btnNo.addTarget(self,
                        action: #selector(actNo),
                        for: UIControl.Event.touchUpInside)
        btnNo.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnNo)
        
        let btnYes: UIButton = UIButton(frame: CGRect(x: (dialogWidth / 2) + 8,
                                                     y: originY,
                                                     width: (dialogWidth / 2) - 24,
                                                     height: 40))
        btnYes.setTitle(self.popAlertData.popYesButtonText,
                        for: UIControl.State.normal)
        btnYes.backgroundColor = self.popAlertData.popYesButtonColor
        btnYes.setTitleColor(UIColor.white,
                             for: UIControl.State.normal)
        btnYes.addTarget(self,
                         action: #selector(actSelection),
                         for: UIControl.Event.touchUpInside)
        btnYes.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnYes)
        originY += btnYes.frame.height + 15
        
        vwDialog.frame = CGRect(x: 30,
                                y: frame.height,
                                width: dialogWidth,
                                height: originY)
        vwDialog.backgroundColor = UIColor.white
        vwDialog.cornerRadius(cornerRadius: 5)
        addSubview(vwDialog)
    }
    
    /// Used to draw the Date Selection Alert outlets and it's functionalities.
    func drawDateAlert(){
        
        let dialogWidth: CGFloat = frame.size.width - 60
        var originY: CGFloat = 10
        
        vwDialog.clipsToBounds = true
        
        vwBackground.frame = frame
        vwBackground.backgroundColor = UIColor.black
        vwBackground.alpha = 0.75
        vwBackground.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(didTappedOnvwBackground)))
        self.addSubview(vwBackground)
        
        let lblTitle: UILabel = UILabel(frame: CGRect(x: 10,
                                                     y: originY,
                                                     width: dialogWidth - 20,
                                                     height: getContainerHeight(accordingTo: self.popAlertData.popTitle,
                                                                                aFont: UIFont.systemFont(ofSize: 14),
                                                                                containerWidth: dialogWidth - 20) + CGFloat(10)))
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.text = self.popAlertData.popTitle
        vwDialog.addSubview(lblTitle)
        originY += lblTitle.frame.height + 8
        
        if self.popAlertData.popMessage != nil && self.popAlertData.popMessage != ""{
            let lblMessage: UILabel = UILabel(frame: CGRect(x: 10,
                                                           y: originY,
                                                           width: dialogWidth - 20,
                                                           height: getContainerHeight(accordingTo: self.popAlertData.popMessage ?? "",
                                                                                      aFont: UIFont.systemFont(ofSize: 14),
                                                                                      containerWidth: dialogWidth - 40) + CGFloat(10)))
            lblMessage.font = UIFont.systemFont(ofSize: 14)
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.text = self.popAlertData.popMessage
            lblMessage.numberOfLines = 0
            vwDialog.addSubview(lblMessage)
            originY += lblMessage.frame.height + 8
        }
        
        let pckDate: UIDatePicker = UIDatePicker(frame: CGRect(x: 10, y: originY, width: dialogWidth - 20, height: 200))
        pckDate.calendar = Calendar.current
        pckDate.date = Date()
        pckDate.datePickerMode = UIDatePicker.Mode.date
        pckDate.locale = Locale(identifier: "es")
        pckDate.addTarget(self, action: #selector(actChangeDate(sender:)), for: UIControl.Event.valueChanged)
        vwDialog.addSubview(pckDate)
        originY += pckDate.frame.height+20
        
        let btnNo: UIButton = UIButton(frame: CGRect(x: 16,
                                                    y: originY,
                                                    width: (dialogWidth / 2) - 24,
                                                    height: 40))
        btnNo.setTitle(self.popAlertData.popNoButtonText,
                       for: UIControl.State.normal)
        btnNo.backgroundColor = self.popAlertData.popNoButtonColor
        btnNo.setTitleColor(UIColor.white,
                            for: UIControl.State.normal)
        btnNo.addTarget(self,
                        action: #selector(actNo),
                        for: UIControl.Event.touchUpInside)
        btnNo.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnNo)
        
        let btnYes: UIButton = UIButton(frame: CGRect(x: (dialogWidth / 2) + 8,
                                                     y: originY,
                                                     width: (dialogWidth / 2) - 24,
                                                     height: 40))
        btnYes.setTitle(self.popAlertData.popYesButtonText,
                        for: UIControl.State.normal)
        btnYes.backgroundColor = self.popAlertData.popYesButtonColor
        btnYes.setTitleColor(UIColor.white,
                             for: UIControl.State.normal)
        btnYes.addTarget(self,
                         action: #selector(actDate),
                         for: UIControl.Event.touchUpInside)
        btnYes.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnYes)
        originY += btnYes.frame.height + 15
        
        vwDialog.frame = CGRect(x: 30,
                                y: frame.height,
                                width: dialogWidth,
                                height: originY)
        vwDialog.backgroundColor = UIColor.white
        vwDialog.cornerRadius(cornerRadius: 5)
        addSubview(vwDialog)
    }
    
    /// Used to draw the Yes No Alert outlets and it's functionalities.
    ///
    /// - Parameter anImage: An optional image for the FORPopUp view. (If the image is nil, the view will not draw the image container)
    func drawYesNoAlert(anImage: UIImage?){
        
        let dialogWidth: CGFloat = frame.size.width - 60
        var originY: CGFloat = 10
        
        vwDialog.clipsToBounds = true
        
        vwBackground.frame = frame
        vwBackground.backgroundColor = UIColor.black
        vwBackground.alpha = 0.75
        vwBackground.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(didTappedOnvwBackground)))
        self.addSubview(vwBackground)
        
        if let alertImage = anImage{
            let imgAlert:UIImageView = UIImageView(frame: CGRect(x: (dialogWidth / 2) - 25,
                                                                 y: originY,
                                                                 width: 50,
                                                                 height: 50))
            imgAlert.image = alertImage
            imgAlert.contentMode = UIView.ContentMode.scaleAspectFit
            vwDialog.addSubview(imgAlert)
            originY += imgAlert.frame.height + 15
        }
        
        let lblTitle: UILabel = UILabel(frame: CGRect(x: 10,
                                                     y: originY,
                                                     width: dialogWidth - 20,
                                                     height: getContainerHeight(accordingTo: self.popAlertData.popTitle,
                                                                                aFont: UIFont.systemFont(ofSize: 14),
                                                                                containerWidth: dialogWidth - 20) + CGFloat(10)))
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.text = self.popAlertData.popTitle
        vwDialog.addSubview(lblTitle)
        originY += lblTitle.frame.height + 16
        
        if self.popAlertData.popMessage != nil && self.popAlertData.popMessage != ""{
            let lblMessage:UILabel = UILabel(frame: CGRect(x: 10,
                                                           y: originY,
                                                           width: dialogWidth - 20,
                                                           height: getContainerHeight(accordingTo: self.popAlertData.popMessage ?? "",
                                                                                      aFont: UIFont.systemFont(ofSize: 14),
                                                                                      containerWidth: dialogWidth - 20) + CGFloat(10)))
            lblMessage.font = UIFont.systemFont(ofSize: 14)
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.text = self.popAlertData.popMessage
            lblMessage.numberOfLines = 0
            vwDialog.addSubview(lblMessage)
            originY += lblMessage.frame.height + 30
        }
        
        let btnNo: UIButton = UIButton(frame: CGRect(x: 16,
                                                    y: originY,
                                                    width: (dialogWidth / 2) - 24,
                                                    height: 40))
        btnNo.setTitle(self.popAlertData.popNoButtonText,
                       for: UIControl.State.normal)
        btnNo.backgroundColor = self.popAlertData.popNoButtonColor
        btnNo.setTitleColor(UIColor.white,
                            for: UIControl.State.normal)
        btnNo.addTarget(self,
                        action: #selector(actNo),
                        for: UIControl.Event.touchUpInside)
        btnNo.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnNo)
        
        let btnYes: UIButton = UIButton(frame: CGRect(x: (dialogWidth / 2) + 8,
                                                     y: originY,
                                                     width: (dialogWidth / 2) - 24,
                                                     height: 40))
        btnYes.setTitle(self.popAlertData.popYesButtonText,
                        for: UIControl.State.normal)
        btnYes.backgroundColor = self.popAlertData.popYesButtonColor
        btnYes.setTitleColor(UIColor.white,
                             for: UIControl.State.normal)
        btnYes.addTarget(self,
                         action: #selector(actYes),
                         for: UIControl.Event.touchUpInside)
        btnYes.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnYes)
        originY += btnYes.frame.height + 15
        
        vwDialog.frame = CGRect(x: 30,
                                y: frame.height,
                                width: dialogWidth,
                                height: originY)
        vwDialog.backgroundColor = UIColor.white
        vwDialog.cornerRadius(cornerRadius: 5)
        addSubview(vwDialog)
    }
    
    func drawOKAlert(){
        let dialogWidth: CGFloat = frame.size.width - 60
        var originY: CGFloat = 10
        
        vwDialog.clipsToBounds = true
        
        vwBackground.frame = frame
        vwBackground.backgroundColor = UIColor.black
        vwBackground.alpha = 0.75
        vwBackground.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(didTappedOnvwBackground)))
        self.addSubview(vwBackground)
        
        let lblTitle: UILabel = UILabel(frame: CGRect(x: 10,
                                                     y: originY,
                                                     width: dialogWidth - 20,
                                                     height: getContainerHeight(accordingTo: self.popAlertData.popTitle,
                                                                                aFont: UIFont.systemFont(ofSize: 14),
                                                                                containerWidth: dialogWidth - 20) + CGFloat(10)))
        lblTitle.font = UIFont.boldSystemFont(ofSize: 18)
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.text = self.popAlertData.popTitle
        vwDialog.addSubview(lblTitle)
        originY += lblTitle.frame.height + 16
        
        if self.popAlertData.popMessage != nil && self.popAlertData.popMessage != ""{
            let lblMessage: UILabel = UILabel(frame: CGRect(x: 10,
                                                           y: originY,
                                                           width: dialogWidth - 20,
                                                           height: getContainerHeight(accordingTo: self.popAlertData.popMessage ?? "",
                                                                                      aFont: UIFont.systemFont(ofSize: 14),
                                                                                      containerWidth: dialogWidth - 20) + CGFloat(10)))
            lblMessage.font = UIFont.systemFont(ofSize: 14)
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.text = self.popAlertData.popMessage
            lblMessage.numberOfLines = 0
            vwDialog.addSubview(lblMessage)
            originY += lblMessage.frame.height + 30
        }
        
        let btnYes: UIButton = UIButton(frame: CGRect(x: (dialogWidth / 2) - ((dialogWidth / 2) - 24) / 2,
                                                     y: originY,
                                                     width: (dialogWidth / 2) - 24,
                                                     height: 40))
        btnYes.setTitle(self.popAlertData.popOkButtonText,
                        for: UIControl.State.normal)
        btnYes.backgroundColor = self.popAlertData.popOKButtonColor
        btnYes.setTitleColor(UIColor.white,
                             for: UIControl.State.normal)
        btnYes.addTarget(self,
                         action: #selector(actYes),
                         for: UIControl.Event.touchUpInside)
        btnYes.cornerRadius(cornerRadius: 5)
        vwDialog.addSubview(btnYes)
        originY += btnYes.frame.height + 15
        
        vwDialog.frame = CGRect(x: 30,
                                y: frame.height,
                                width: dialogWidth,
                                height: originY)
        vwDialog.backgroundColor = UIColor.white
        vwDialog.cornerRadius(cornerRadius: 5)
        addSubview(vwDialog)
    }
    
    func initialize(aTitle: String, aMessage: String){
        
        let vwDialogWidth: CGFloat = frame.width - 60
        var originY: CGFloat = 10
        
        vwDialog.clipsToBounds = true
        
        vwBackground.frame = frame
        vwBackground.backgroundColor = UIColor.black
        vwBackground.alpha = 0.6
        vwBackground.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                                                                      action: #selector(didTappedOnvwBackground)))
        self.addSubview(vwBackground)
        
        let lblTitle: UILabel = UILabel(frame: CGRect(x: 10,
                                                                                   y: originY,
                                                                                   width: vwDialogWidth - 20,
                                                                                   height: 40))
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lblTitle.text = aTitle
        lblTitle.textAlignment = NSTextAlignment.center
        vwDialog.addSubview(lblTitle)
        originY += lblTitle.frame.height + 10
        
        let vwSeparator: UIView = UIView(frame: CGRect(x: 0,
                                                                                           y: originY,
                                                                                           width: vwDialogWidth,
                                                                                           height: 1))
        vwSeparator.backgroundColor = UIColor.groupTableViewBackground
        vwDialog.addSubview(vwSeparator)
        
        if self.popAlertData.popMessage != nil && self.popAlertData.popMessage != ""{
            let lblMessage: UILabel = UILabel(frame: CGRect(x: 10,
                                                           y: originY,
                                                           width: vwDialogWidth - 20,
                                                           height: 30))
            lblMessage.font = UIFont.systemFont(ofSize: 12)
            lblMessage.text = aMessage
            lblMessage.textAlignment = NSTextAlignment.center
            lblMessage.numberOfLines = 0
            vwDialog.addSubview(lblMessage)
            originY += lblMessage.frame.height + 10
        }
        
        vwDialog.frame = CGRect(x: 30, y: frame.height, width: vwDialogWidth, height: originY)
        vwDialog.backgroundColor = UIColor.white
        vwDialog.cornerRadius(cornerRadius: 5)
        addSubview(vwDialog)
    }
    
    /// Used to dismiss the FORPopUpView when tapped in the vwBackground.
    @objc func didTappedOnvwBackground(){
        
        dismiss(animated: true)
    }
    
    //MARK: ACTIONS
    
    @objc func actLogin(){
        
        if arrTextFields[0].text!.isEmpty || !arrTextFields[0].text!.isAValidEmail{
            
            arrTextFields[0].showInvalidInputStateWhen(isValidInput: true)
            arrTextFields[0].shake(count: nil, duration: nil, translation: nil)
        }else{
            
            if arrTextFields[1].text!.isEmpty{
                
                arrTextFields[1].showInvalidInputStateWhen(isValidInput: true)
                arrTextFields[1].shake(count: nil, duration: nil, translation: nil)
            }else{
                if let anAction = self.yesNoSuccess{
                    anAction(true)
                }
            }
        }
        self.vwDialog.endEditing(true)
    }
    
    /// Used to validate if the tfEmail has a valid email address. If it's a valid mail it will perform a request to the corresponding web service; otherwise it will display an exclamation image in the textfield and perform a shake animation.
    @objc func actRecoverPassword(){
        
        if let aTextfield = tfToValidate{
            
            if aTextfield.text!.isEmpty || !aTextfield.text!.isAValidEmail{
                
                aTextfield.showInvalidInputStateWhen(isValidInput: true)
                aTextfield.shake(count: nil, duration: nil, translation: nil)
            }else{
                
                if let anAction = self.yesNoSuccess{
                    anAction(true)
                }
            }
        }else{
            
            dismiss(animated: true)
        }
        self.vwDialog.endEditing(true)
    }
    
    /// Used to return a true value from the FORPopUp when pressing the Yes Button.
    @objc func actYes(){
        
        if let anAction = self.yesNoSuccess{
            
            anAction(true)
        }
    }
    
    /// Used to return a false value from the FORPopUp when pressing the No Button.
    @objc func actNo(){
        
        if let anAction = self.yesNoSuccess{
            
            anAction(false)
        }
    }
    
    /// Used to set the corresponding date to the FORPopUp data.
    ///
    /// - Parameter sender: The UIDatePicker of the FORPopUp.
    @objc func actChangeDate(sender: UIDatePicker){
        
        self.dateSelected = sender.date
    }
    
    /// Used to return a date value from the FORPopUp when pressing the Yes Button.
    @objc func actDate(){
        
        if let anAction = self.dateSelection{
            
            anAction(self.dateSelected ?? Date())
        }
    }
    
    @objc func actSelection() {
        
        if let anAction = self.pickerSelection {
            
            anAction(self.arrSelectOptions[selectedSegmentIndex ?? 0])
        }
    }
}

//MARK: - FORAlertExtensions

extension FORPopUpView: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeTextField = textField
        textField.showInvalidInputStateWhen(isValidInput: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if arrTextFields?.count == 1{
            
            self.endEditing(true)
        }else{
            switch textField{
                
            default:
                self.endEditing(true)
            }
        }
        return true
    }
}

//MARK: - FORAlertSupportMethods

/// Used to get the corresponding height needed by an outlet according to a text that should be displayed.
///
/// - Parameters:
///   - aText: The text that will be displayed by the outlet.
///   - aFont: The corresponding font for the displayed text.
///   - containerWidth: The width that the displaying outlet will have.
/// - Returns: The height that the outlet must has to display all the text.
public func getContainerHeight(accordingTo aText: String, aFont: UIFont, containerWidth: CGFloat)->CGFloat{
    
    let attributedText: NSAttributedString = NSAttributedString(string: aText,
                                                                attributes: [NSAttributedString.Key.font : aFont])
    let lblTextRect: CGRect = attributedText.boundingRect(with: CGSize(width: containerWidth,
                                                                       height: CGFloat.greatestFiniteMagnitude),
                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                          context: nil)
    return lblTextRect.height
}

/// Used to get the corresponding height needed by an outlet according to a NSAttributedString that should be displayed.
///
/// - Parameters:
///   - attributedText: The NSAttributedString that will be displayed by the outlet.
///   - containerWidth: The width that the displaying outlet will have.
/// - Returns: The height that the outlet must has to display all the text.
public func getContainerHeight(accordingTo attributedText: NSAttributedString, containerWidth: CGFloat)->CGFloat{
    
    let lblTextRect: CGRect = attributedText.boundingRect(with: CGSize(width: containerWidth,
                                                                       height: CGFloat.greatestFiniteMagnitude),
                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                          context: nil)
    return lblTextRect.height
}

extension FORPopUpView:UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrSelectOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedSegmentIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrSelectOptions[row]
    }
}
