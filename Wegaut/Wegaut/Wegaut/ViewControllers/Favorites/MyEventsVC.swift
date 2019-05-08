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
    var arrFilteredEvents: [Event]!
    var isSearching: Bool = false {
        didSet {
            tvMyEvents.reloadData()
        }
    }
    var selectedEvent: Event?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvMyEvents: UITableView!
    @IBOutlet weak var sbEvents: UISearchBar!
    var vwSearchFooter: FORFooterSearchResults!
    var rcEvents:UIRefreshControl!
    
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

    // MARK: - NAVIGATION

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowMyEventDetail" {
            
            let destinationVC: EventFeedDetailVC = segue.destination as! EventFeedDetailVC
            destinationVC.currentEvent = selectedEvent
        }
    }
    
    //MARK: - FUNCTIONS
    
    func updateSearchResults(searchText: String) {
        
        arrFilteredEvents =  arrMyEvents.filter{$0.eveName.lowercased().contains(searchText.lowercased())}
        tvMyEvents.reloadData()
    }
    
    @objc func getEvents() {
        
        arrMyEvents = Event.getEvents()
        if self.rcEvents != nil{
            self.rcEvents.endRefreshing()
        }
        tvMyEvents.reloadData()
    }
    
    /// Add Refresh Control to the table view.
    func addRefreshControlToTableView(){
        
        rcEvents = UIRefreshControl()
        rcEvents.addTarget(self,
                           action: #selector(self.getEvents),
                           for: UIControl.Event.valueChanged)
        tvMyEvents.addSubview(rcEvents)
    }
}

//MARK: - EXTENSIONS

extension MyEventsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if arrMyEvents.count == 0 {
            
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
        
        return arrMyEvents.count == 0 ? 50 : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isSearching ? vwSearchFooter.setIsFilteringToShow(filteredItemCount: arrFilteredEvents.count,
                                                          of: arrMyEvents.count) : vwSearchFooter.setNotFiltering()
        return isSearching ? arrFilteredEvents.count : arrMyEvents.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 179
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: EventCountdownTVCell = tableView.dequeueReusableCell(withIdentifier: "CountDownCell",
                                                                        for: indexPath) as! EventCountdownTVCell
        aCell.currentEvent = isSearching ? arrFilteredEvents[indexPath.row] : arrMyEvents[indexPath.row]
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedEvent = arrMyEvents[indexPath.row]
        self.performSegue(withIdentifier: "ShowMyEventDetail",
                          sender: self)
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

extension MyEventsVC: UISearchBarDelegate {
    
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

extension MyEventsVC: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        dismissKeyboard()
    }
}
