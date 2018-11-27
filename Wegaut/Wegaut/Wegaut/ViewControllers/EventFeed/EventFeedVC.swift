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
    var selectedEvent: Event!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvFeed: UITableView!
    @IBOutlet weak var sbEvents: UISearchBar!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        let bbiFeed: UIBarButtonItem = UIBarButtonItem(title: "EVF_TIT".localized,
                                                       style: UIBarButtonItem.Style.plain,
                                                       target: nil,
                                                       action: nil)
        self.navigationItem.setLeftBarButton(bbiFeed,
                                             animated: false)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        sbEvents.barTintColor = UIColor.deepPurple
        sbEvents.placeholder = "EVF_SEARCH".localized
        arrEvents = Event.getEvents()
        self.addImageLogoToNavBar()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowDetail" {
            
            let destinationVC: EventFeedDetailVC = segue.destination as! EventFeedDetailVC
            destinationVC.currentEvent = selectedEvent
        }
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
        
        return tableView.frame.height - 100
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedEvent = arrEvents[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetail",
                          sender: nil)
    }
}
