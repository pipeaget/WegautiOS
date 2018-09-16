//
//  WalkThroughContentVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/19/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class WalkThroughContentVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var index = 0
    var strHeader = ""
    var strSubHeader = ""
    var strImageName = ""
    
    //MARK: - OUTLETS
    
    @IBOutlet var lblHeader: UILabel!{
        didSet{
            lblHeader.numberOfLines = 0
        }
    }
    @IBOutlet var lblSubHeader: UILabel!{
        didSet{
            lblSubHeader.numberOfLines = 0
        }
    }
    @IBOutlet var vwimgContent: UIImageView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        lblHeader.text = strHeader
        lblSubHeader.text = strSubHeader
        vwimgContent.image = UIImage(named: strImageName)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
