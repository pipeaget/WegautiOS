//
//  EventFeedVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class EventFeedVC: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let bbiAdd: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BBIAdd"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.addNewEvent(sender:)))
        self.navigationItem.setRightBarButton(bbiAdd, animated: false)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - ACTIONS
    
    @objc func addNewEvent(sender: UIBarButtonItem){
        
        self.performSegue(withIdentifier: "ShowNewEvent", sender: self)
    }

}
