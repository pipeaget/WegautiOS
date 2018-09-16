//
//  LoginVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/12/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - ENUMS
    
    enum userInput {
        
        case login
        case forgotPassword
    }
    
    //MARK: - VARIABLES
    
    var currentUserInputStatus: userInput = userInput.login {
        didSet {
            updateInputStatus()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblSlogan: UILabel!
    @IBOutlet weak var vwLogin: UIView!
    @IBOutlet weak var vwUser: UIView!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var vwDivider: UIView!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: NSNotification.Name.UIKeyboardDidHide,
                                               object: nil)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let tgrDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                                action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tgrDismissKeyboard)
        tfUser.delegate = self
        tfPassword.delegate = self
        
        lblSlogan.text = "LOG_SLO".localized
        lblUser.text = "LOG_USR".localized
        lblPassword.text = "LOG_PSSWD".localized
        btnLogin.setTitle("LOG_LOG".localized,
                          for: UIControlState.normal)
        let strFP: NSAttributedString = NSAttributedString(string: "LOG_FP".localized,
                                                           attributes: [NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue,
                                                                        NSAttributedStringKey.foregroundColor : UIColor.white])
        btnForgotPassword.setAttributedTitle(strFP,
                                             for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    // MARK: - NAVIGATION

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - UIKEYBOARD NOTIFICATION HANDLER
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let userInfo = (notification as NSNotification).userInfo {
            
            if self.view.frame.origin.y == 0 {
                
                self.view.frame.origin.y -= (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        self.view.frame.origin.y = 0
    }
    
    //MARK: - FUNCTIONS
    
    func updateInputStatus() {
        
        switch currentUserInputStatus {
            
        case .login:
            btnLogin.setTitle("LOG_LOG".localized,
                              for: UIControlState.normal)
            vwUser.isHidden = false
            lblUser.text = "LOG_USR".localized
            lblPassword.text = "LOG_PSSWD".localized
            let strFP: NSAttributedString = NSAttributedString(string: "LOG_FP".localized,
                                                               attributes: [NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue,
                                                                            NSAttributedStringKey.foregroundColor : UIColor.white])
            btnForgotPassword.setAttributedTitle(strFP,
                                                 for: UIControlState.normal)
            vwDivider.isHidden = false
            
        default:
            btnLogin.setTitle("LOG_RP".localized,
                              for: UIControlState.normal)
            vwUser.isHidden = true
            lblPassword.text = "LOG_USR".localized
            let strFP: NSAttributedString = NSAttributedString(string: "LOG_RLOG".localized,
                                                               attributes: [NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue,
                                                                            NSAttributedStringKey.foregroundColor : UIColor.white])
            btnForgotPassword.setAttributedTitle(strFP,
                                                 for: UIControlState.normal)
            vwDivider.isHidden = true
        }
        tfUser.showInvalidInputStateWhen(isValidInput: false)
        tfPassword.showInvalidInputStateWhen(isValidInput: false)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnLogin(_ sender: UIButton) {
        
        switch currentUserInputStatus {
            
        case .login:
            var strErrorMessage: String = ""
            var tfError: UITextField?
            if !tfUser.text!.isAValidEmail {
                
                strErrorMessage = "LOG_INVMAIL".localized
                tfError = tfUser
            } else if tfPassword.text!.isEmpty {
                
                strErrorMessage = "LOG_INVPSSWD".localized
                tfError = tfPassword
            }
            if strErrorMessage != "" {
                
                let alertVC: UIAlertController = UIAlertController(title: "ERROR",
                                                                   message: strErrorMessage,
                                                                   preferredStyle: UIAlertControllerStyle.alert)
                alertVC.addAction(UIAlertAction(title: "OK",
                                                style: UIAlertActionStyle.destructive,
                                                handler: nil))
                self.present(alertVC,
                             animated: true) {
                                if let _ = tfError {
                                    
                                    tfError?.showInvalidInputStateWhen(isValidInput: true)
                                }
                }
            } else {
               
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main",
                                                            bundle: Bundle.main)
                let rootNavigation: UITabBarController = storyBoard.instantiateViewController(withIdentifier: "RootNavigation") as! UITabBarController
                self.present(rootNavigation,
                             animated: true,
                             completion: nil)
            }
            
        default:
            
            var alertVC: UIAlertController = UIAlertController()
            var isErrorAlert: Bool = false
            if !tfPassword.text!.isAValidEmail {
                
                isErrorAlert = true
                alertVC = UIAlertController(title: "ERROR",
                                            message: "LOG_INVMAIL".localized,
                                            preferredStyle: UIAlertControllerStyle.alert)
            } else {
                
                alertVC = UIAlertController(title: "LOG_MAILTIT".localized,
                                            message: "LOG_MAILSENT".localized,
                                            preferredStyle: UIAlertControllerStyle.alert)
            }
            alertVC.addAction(UIAlertAction(title: "OK",
                                            style: UIAlertActionStyle.destructive,
                                            handler: nil))
            self.present(alertVC,
                         animated: true) {
                            
                            if isErrorAlert {
                                
                                self.tfPassword.showInvalidInputStateWhen(isValidInput: true)
                            } else {
                                
                                self.currentUserInputStatus = userInput.login
                            }
            }
        }
    }
    
    @IBAction func actForgotPassword(_ sender: UIButton) {
        
        switch currentUserInputStatus {
            
        case .login:
            currentUserInputStatus = userInput.forgotPassword
            
        default:
            currentUserInputStatus = userInput.login
        }
    }
    
    @IBAction func actRegister(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showRegister",
                          sender: nil)
    }
}

//MARK: - EXTENSIONS

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.showInvalidInputStateWhen(isValidInput: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case tfUser:
            tfPassword.becomeFirstResponder()
            
        default:
            dismissKeyboard()
        }
        return true
    }
}
