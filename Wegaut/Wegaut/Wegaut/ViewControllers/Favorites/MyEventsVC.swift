//
//  MyEventsVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/20/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class MyEventsVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrMyEvents: [Event]!{
        didSet{
            tvMyEvents.reloadData()
        }
    }
    var selectedEvent: Event?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvMyEvents: UITableView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrMyEvents = Event.getEvents()
        tvMyEvents.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    // MARK: - NAVIGATION

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowMyEventDetail" {
            
            let destinationVC: EventTimelineVC = segue.destination as! EventTimelineVC
            destinationVC.currentEvent = selectedEvent
        }
    }
}

//MARK: - EXTENSIONS

extension MyEventsVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrMyEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: EventCountdownTVCell = tableView.dequeueReusableCell(withIdentifier: "CountDownCell",
                                                                        for: indexPath) as! EventCountdownTVCell
        aCell.currentEvent = arrMyEvents[indexPath.row]
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedEvent = arrMyEvents[indexPath.row]
        self.performSegue(withIdentifier: "ShowMyEventDetail",
                          sender: self)
    }
}

