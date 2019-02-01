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
    
    var arrEvents: [Event]!
    var arrFilteredEvents: [Event]!
    var selectedEvent: Event!
    var isSearching: Bool = false {
        didSet {
            tvFeed.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvFeed: UITableView!
    @IBOutlet weak var sbEvents: UISearchBar!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        sbEvents.delegate = self
        sbEvents.showsCancelButton = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        sbEvents.barTintColor = UIColor.deepPurple
        sbEvents.tintColor = UIColor.white
        sbEvents.placeholder = "EVF_SEARCH".localized
        arrEvents = Event.getEvents()
        arrFilteredEvents = []
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
    
    func updateSearchResults(searchText: String) {
        
        arrFilteredEvents =  arrEvents.filter{$0.eveName.lowercased().contains(searchText.lowercased())}
        tvFeed.reloadData()
    }
    
    //MARK: - ACTIONS

}

extension EventFeedVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isSearching ? arrFilteredEvents.count : arrEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height - 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: EventFeedTVCell = tableView.dequeueReusableCell(withIdentifier: "EventFeedCell",
                                                                   for: indexPath) as! EventFeedTVCell
        aCell.currentEvent = isSearching ? arrFilteredEvents[indexPath.row] : arrEvents[indexPath.row]
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedEvent = isSearching ? arrFilteredEvents[indexPath.row] : arrEvents[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetail",
                          sender: nil)
    }
}

extension EventFeedVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = searchBar.text != "" ? true : false
        updateSearchResults(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.dismissKeyboard()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        self.dismissKeyboard()
    }
}
