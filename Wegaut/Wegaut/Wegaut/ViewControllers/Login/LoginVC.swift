//
//  LoginVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/12/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class LoginVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var activeField: UITextField?
    
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
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var cnBottomVwLogin: NSLayoutConstraint!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let tgrDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                                action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tgrDismissKeyboard)
        tfUser.delegate = self
        tfUser.keyboardType = UIKeyboardType.emailAddress
        tfPassword.delegate = self
        tfPassword.isSecureTextEntry = true
        lblSlogan.text = "LOG_SLO".localized
        lblUser.text = "LOG_USR".localized
        lblPassword.text = "LOG_PSSWD".localized
        btnLogin.setTitle("LOG_LOG".localized,
                          for: UIControl.State.normal)
        let strFP: NSAttributedString = NSAttributedString(string: "LOG_FP".localized,
                                                           attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                                        NSAttributedString.Key.foregroundColor : UIColor.white])
        btnForgotPassword.setAttributedTitle(strFP,
                                             for: UIControl.State.normal)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    // MARK: - NAVIGATION

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - NOTIFICATION CENTER
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if let _ = self.activeField {
            
            self.lblSlogan.isHidden = true
            self.cnBottomVwLogin.constant = -keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        lblSlogan.isHidden = false
        cnBottomVwLogin.constant = 0
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnLogin(_ sender: UIButton) {
        
        dismissKeyboard()
        KVNProgress.show(withStatus: "LOG_VALDATA".localized)
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
            
            let alertVC: UIAlertController = UIAlertController(title: "ERROR".localized,
                                                               message: strErrorMessage,
                                                               preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "OK".localized,
                                            style: UIAlertAction.Style.destructive,
                                            handler: nil))
            KVNProgress.dismiss()
            self.present(alertVC,animated: true) {
                            if let _ = tfError {
                                tfError?.showInvalidInputStateWhen(isValidInput: true)
                            }
            }
        } else {

          Auth.auth().signIn(withEmail: tfUser.text!, password: tfPassword.text!) { (authResult, error) in
            if let _ = error {
              let anAlert = UIAlertController(title: "ERROR".localized, message: "LOG_FAIL".localized, preferredStyle: UIAlertController.Style.alert)
              anAlert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.destructive, handler: { (alert) in
                self.tfUser.showInvalidInputStateWhen(isValidInput: true)
                self.tfUser.text = ""
                self.tfPassword.showInvalidInputStateWhen(isValidInput: true)
                self.tfPassword.text = ""
              }))
                KVNProgress.dismiss()
                self.present(anAlert, animated: true, completion: nil)
            } else {
                if let aUserData = authResult {
                    UserDefaults.standard.set(aUserData.user.uid, forKey: WegautConstants.USER_ID)
                    UserDefaults.standard.set(true, forKey: WegautConstants.IS_USER_LOGGED)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootNavigation: UITabBarController = storyBoard.instantiateViewController(withIdentifier: "RootNavigation") as! UITabBarController
                    KVNProgress.dismiss()
                    self.present(rootNavigation, animated: true, completion: nil)
                } else {
                    let anAlert = UIAlertController(title: "ERROR".localized, message: "LOG_FAIL".localized, preferredStyle: UIAlertController.Style.alert)
                    anAlert.addAction(UIAlertAction(title: "OK".localized, style: UIAlertAction.Style.destructive, handler: { (alert) in
                        self.tfUser.showInvalidInputStateWhen(isValidInput: true)
                        self.tfUser.text = ""
                        self.tfPassword.showInvalidInputStateWhen(isValidInput: true)
                        self.tfPassword.text = ""
                    }))
                    KVNProgress.dismiss()
                    self.present(anAlert, animated: true, completion: nil)
                }
            }
          }
        }
    }
    
    @IBAction func actForgotPassword(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showForgotPassword",
                          sender: nil)
    }
    
    @IBAction func actGoBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - EXTENSIONS

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        activeField = textField
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
