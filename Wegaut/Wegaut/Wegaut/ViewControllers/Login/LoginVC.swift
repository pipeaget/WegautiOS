//
//  LoginVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/12/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - VARIABLES
    
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
                          for: UIControl.State.normal)
        let strFP: NSAttributedString = NSAttributedString(string: "LOG_FP".localized,
                                                           attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                                        NSAttributedString.Key.foregroundColor : UIColor.white])
        btnForgotPassword.setAttributedTitle(strFP,
                                             for: UIControl.State.normal)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    // MARK: - NAVIGATION

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actBtnLogin(_ sender: UIButton) {
        
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
                                                               preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "OK",
                                            style: UIAlertAction.Style.destructive,
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
    }
    
    @IBAction func actForgotPassword(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showForgotPassword",
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
