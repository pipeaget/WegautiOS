//
//  ForgotPasswordVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 10/1/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var btnResetPassword: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        btnBack.setTitle("FP_BACK".localized,
                         for: UIControl.State.normal)
        lblTitle.text = "FP_TIT".localized
        lblMessage.text = "FP_MESS".localized
        tfEmail.placeholder = "FP_MAIL".localized
        btnResetPassword.setTitle("FP_RPASS".localized,
                                  for: UIControl.State.normal)
    }

    //MARK: - ACTIONS
    
    @IBAction func actBack(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actResetPassword(_ sender: UIButton) {
        
        var strErrorMessage: String = ""
        var tfError: UITextField?
        if !tfEmail.text!.isAValidEmail {
            
            strErrorMessage = "LOG_INVMAIL".localized
            tfError = tfEmail
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
            
            let alertVC: UIAlertController = UIAlertController(title: "",
                                                               message: "FP_RECPASS",
                                                               preferredStyle: UIAlertController.Style.alert)
            alertVC.addAction(UIAlertAction(title: "OK",
                                            style: UIAlertAction.Style.destructive, handler: { (alert) in
                                                
                                                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alertVC,
                         animated: true,
                         completion: nil)
        }
    }
}
