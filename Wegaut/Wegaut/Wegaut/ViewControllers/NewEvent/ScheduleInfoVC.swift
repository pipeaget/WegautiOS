//
//  ScheduleInfoVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class ScheduleInfoVC: UIViewController {
    
    //MARK: - VARIABLES
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblEventInitialDate: UILabel!
    @IBOutlet weak var dpInitialDate: UIDatePicker!
    @IBOutlet weak var lblEventEndDate: UILabel!
    @IBOutlet weak var dpEndDate: UIDatePicker!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        lblEventInitialDate.text = "SIVC_INDA".localized
        lblEventEndDate.text = "SIVC_ENDA".localized
        
        let currentDate: Date = Date()
        let initialDateMinimum = currentDate.addingTimeInterval(1800)
        let initialDateMaximum = initialDateMinimum.addingTimeInterval(15768000)
        let endDateMinimum = dpInitialDate.date.addingTimeInterval(3600)
        let endDateMaximum = endDateMinimum.addingTimeInterval(15768000)
        dpInitialDate.minimumDate = initialDateMinimum
        dpInitialDate.maximumDate = initialDateMaximum
        dpInitialDate.locale = Locale.current
        dpInitialDate.calendar = Calendar.current
        dpInitialDate.timeZone = NSTimeZone.local
        dpEndDate.minimumDate = endDateMinimum
        dpEndDate.maximumDate = endDateMaximum
        dpEndDate.locale = Locale.current
        dpEndDate.calendar = Calendar.current
        dpEndDate.timeZone = NSTimeZone.local
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    
    
    //MARK: - ACTIONS

}
