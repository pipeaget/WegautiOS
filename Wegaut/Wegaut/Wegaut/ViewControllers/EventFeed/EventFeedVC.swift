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
    var vwSearchFooter: FORFooterSearchResults!
    var rcEvents: UIRefreshControl!
    
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
        vwSearchFooter = FORFooterSearchResults(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: UIScreen.main.bounds.width,
                                                              height: 64))
        addRefreshControlToTableView()
        getEvents()
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
        } else if segue.identifier == "SeeEventComments" {
            
            let destinationVC: MoreCommentsVC = segue.destination as! MoreCommentsVC
            destinationVC.currentComments = selectedEvent.eveComments
        }
    }
    
    //MARK: - FUNCTIONS
    
    func updateSearchResults(searchText: String) {
        
        arrFilteredEvents =  arrEvents.filter{$0.eveName.lowercased().contains(searchText.lowercased())}
        tvFeed.reloadData()
    }
    
    @objc func getEvents() {
        
        arrEvents = Event.getEvents()
        if self.rcEvents != nil{
            self.rcEvents.endRefreshing()
        }
        self.tvFeed.reloadData()
    }
    
    /// Add Refresh Control to the table view.
    func addRefreshControlToTableView(){
        
        rcEvents = UIRefreshControl()
        rcEvents.addTarget(self,
                           action: #selector(self.getEvents),
                           for: UIControl.Event.valueChanged)
        tvFeed.addSubview(rcEvents)
    }
    
    func seeEventComments() {
        
        self.performSegue(withIdentifier: "SeeEventComments",
                          sender: nil)
    }
    
    func addRemoveUserFromArray(anArray: [User])-> [User] {
        
        var arrToReturn: [User] = anArray
        if anArray.contains(where: {$0.usEmail == User.getUserData().usEmail}) {
            
            arrToReturn = arrToReturn.filter{$0.usEmail != User.getUserData().usEmail}
        } else  {
            
            arrToReturn.append(User.getUserData())
        }
        return arrToReturn
    }
}

extension EventFeedVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if arrEvents.count == 0 {
            
            let screenSize:CGSize = UIScreen.main.bounds.size
            
            let vwHeader:UIView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 50))
            vwHeader.backgroundColor = UIColor.deepPurple
            vwHeader.layer.borderWidth = 0.5
            vwHeader.layer.borderColor = UIColor.white.cgColor
            
            let lblTitle:UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: screenSize.width - 20, height: 30))
            lblTitle.text = isSearching ? "NOT_NO_EVENTS".localized : "".localized
            lblTitle.adjustsFontSizeToFitWidth = true
            lblTitle.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            lblTitle.textColor = UIColor.white
            lblTitle.textAlignment = NSTextAlignment.center
            vwHeader.addSubview(lblTitle)
            
            return vwHeader
            
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return arrEvents.count == 0 ? 50 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isSearching ? vwSearchFooter.setIsFilteringToShow(filteredItemCount: arrFilteredEvents.count,
            of: arrEvents.count) : vwSearchFooter.setNotFiltering()
        return isSearching ? arrFilteredEvents.count : arrEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height - 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: EventFeedTVCell = tableView.dequeueReusableCell(withIdentifier: "EventFeedCell",
                                                                   for: indexPath) as! EventFeedTVCell
        aCell.currentEvent = isSearching ? arrFilteredEvents[indexPath.row] : arrEvents[indexPath.row]
        aCell.actAddRemoveFavorite = {
            
            self.arrEvents[indexPath.row].eveUserFavorited = self.addRemoveUserFromArray(anArray: self.arrEvents[indexPath.row].eveUserFavorited)
            aCell.currentEvent = self.isSearching ? self.arrFilteredEvents[indexPath.row] : self.arrEvents[indexPath.row]
        }
        aCell.actSeeComments = {
            
            self.selectedEvent = self.isSearching ? self.arrFilteredEvents[indexPath.row] : self.arrEvents[indexPath.row]
            self.seeEventComments()
        }
        aCell.actaddRemoveToMyEvents = {
            
            self.arrEvents[indexPath.row].eveAssistants = self.addRemoveUserFromArray(anArray: self.arrEvents[indexPath.row].eveAssistants)
            aCell.currentEvent = self.isSearching ? self.arrFilteredEvents[indexPath.row] : self.arrEvents[indexPath.row]
        }
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedEvent = isSearching ? arrFilteredEvents[indexPath.row] : arrEvents[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetail",
                          sender: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if isSearching && (sbEvents.text!.count > 0){
            return vwSearchFooter
        }
        return  nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if isSearching && (sbEvents.text!.count > 0){
            return 50
        }
        return 0
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
        searchBar.text = ""
        self.dismissKeyboard()
    }
}

extension EventFeedVC: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        dismissKeyboard()
    }
}
