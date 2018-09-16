//
//  EventFeedVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class EventFeedVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrEvents: [Event]! {
        didSet {
            tvFeed.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvFeed: UITableView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let bbiAdd: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "BBIAdd"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.addNewEvent(sender:)))
        self.navigationItem.setRightBarButton(bbiAdd, animated: false)
        arrEvents = Event.getEvents()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    
    //MARK: - ACTIONS
    
    @objc func addNewEvent(sender: UIBarButtonItem){
        
        self.performSegue(withIdentifier: "ShowNewEvent", sender: self)
    }

}

extension EventFeedVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 275
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: EventFeedTVCell = tableView.dequeueReusableCell(withIdentifier: "EventFeedCell",
                                                                   for: indexPath) as! EventFeedTVCell
        return aCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let aCell: EventFeedTVCell = cell as! EventFeedTVCell
        aCell.currentEvent = arrEvents[indexPath.row]
    }
}
