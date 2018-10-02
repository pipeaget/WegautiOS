//
//  WelcomeVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 10/1/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    //MARK: - VARIABLES
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblSlogan: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }


    override func viewDidLoad() {
        
        super.viewDidLoad()
        lblWelcome.text = "WE_WELCOME".localized
        lblSlogan.text = "WE_SLOGAN".localized
        btnLogin.setTitle("WE_LOGIN".localized,
                          for: UIControl.State.normal)
        btnRegister.setTitle("WE_REGISTER".localized,
                             for: UIControl.State.normal)
        let tgrDismissKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                                action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tgrDismissKeyboard)
    }
    
    //MARK: - ACTIONS

    @IBAction func actLogin(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showLogin",
                          sender: nil)
    }
    
    
    @IBAction func actRegister(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showRegister",
                          sender: nil)
    }
}
