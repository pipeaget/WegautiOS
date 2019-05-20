//
//  MyActivitiesVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/20/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class MyActivitiesVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrActivities: [Activity]! {
        didSet {
            updateSubActivities()
        }
    }
    var arrTodayActivities: [Activity]!
    var arrYesterdayActivities: [Activity]!
    var arrFilteredActivities: [Activity]!
    var selectedActivity: Activity!
    var isSearching: Bool = false {
        didSet {
            tvActivities.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvActivities: UITableView!
    @IBOutlet weak var sbActivities: UISearchBar!
    var vwSearchFooter: FORFooterSearchResults!
    var rcActivities: UIRefreshControl!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        arrActivities = []
        arrTodayActivities = []
        arrYesterdayActivities = []
        arrFilteredActivities = []
        getActivities()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        sbActivities.delegate = self
        sbActivities.showsCancelButton = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        sbActivities.barTintColor = UIColor.deepPurple
        sbActivities.tintColor = UIColor.white
        sbActivities.placeholder = "EVF_SEARCH".localized
        tvActivities.rowHeight = UITableView.automaticDimension
        vwSearchFooter = FORFooterSearchResults(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: UIScreen.main.bounds.width,
                                                              height: 64))
        addRefreshControlToTableView()
        self.addImageLogoToNavBar()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowEvent" {
            
            let destinationVC: EventFeedDetailVC = segue.destination as! EventFeedDetailVC
            destinationVC.currentEvent = selectedActivity.actEvent
        } else if segue.identifier == "ShowProfile" {
            
            let destinationVC: ProfileVC =  segue.destination as! ProfileVC
            destinationVC.currentUser = selectedActivity.actUser
        }
    }
    
    //MARK: - FUNCTIONS
    
    func updateSubActivities() {
        
        arrTodayActivities = arrActivities.filter{$0.actDate == "03:02 PM | 13/09/2018"}
        arrYesterdayActivities = arrActivities.filter{$0.actDate != "03:02 PM | 13/09/2018"}
    }
    
    func updateSearchResults(searchText: String) {
        
        arrFilteredActivities = arrActivities.filter{$0.actTitle.lowercased().contains(searchText.lowercased())}
        tvActivities.reloadData()
    }
    
    @objc func getActivities() {
        
        arrActivities = Activity.getActivities()
        updateSubActivities()
        if self.rcActivities != nil{
            self.rcActivities.endRefreshing()
        }
        self.tvActivities.reloadData()
    }
    
    /// Add Refresh Control to the table view.
    func addRefreshControlToTableView(){
        
        rcActivities = UIRefreshControl()
        rcActivities.addTarget(self, action: #selector(self.getActivities), for: UIControl.Event.valueChanged)
        tvActivities.addSubview(rcActivities)
    }
    
    func showEvent() {
        
        self.performSegue(withIdentifier: "ShowEvent",
                          sender: nil)
    }
    
    func changeFollowType(indexPath: IndexPath)-> [Activity] {
        
        var arrToReturn: [Activity] = arrActivities
        if arrToReturn[indexPath.row].actType == ActivityType.newFollower {
            
            arrToReturn[indexPath.row].actType = ActivityType.newFollowing
            
        } else {
            
            arrToReturn[indexPath.row].actType = ActivityType.newFollower
        }
        return arrToReturn
    }
    
    func showFollow() {
        
        self.performSegue(withIdentifier: "ShowProfile",
                          sender: nil)
    }
}

//MARK: - EXTENSIONS

extension MyActivitiesVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if arrActivities.count == 0 {
            
            let screenSize:CGSize = UIScreen.main.bounds.size
            
            let vwHeader:UIView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 50))
            vwHeader.backgroundColor = UIColor.deepPurple
            vwHeader.layer.borderWidth = 0.5
            vwHeader.layer.borderColor = UIColor.white.cgColor
            
            let lblTitle:UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: screenSize.width - 20, height: 30))
            lblTitle.text = "NOT_NO_EVENTS".localized
            lblTitle.adjustsFontSizeToFitWidth = true
            lblTitle.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            lblTitle.textColor = UIColor.white
            lblTitle.textAlignment = NSTextAlignment.center
            vwHeader.addSubview(lblTitle)
            
            return vwHeader
        } else if !isSearching  {
            
            let screenSize: CGRect = UIScreen.main.bounds
            let aView: UIView = UIView(frame: CGRect(x: 0,
                                                     y: 0,
                                                     width: screenSize.width,
                                                     height: 30))
            aView.backgroundColor = UIColor(red: 235/255,
                                            green: 235/255,
                                            blue: 235/255,
                                            alpha: 1)
            let lblTitle: UILabel = UILabel(frame: CGRect(x: 20,
                                                          y: 5,
                                                          width: screenSize.width - 40,
                                                          height: 20))
            lblTitle.text = section == 0 ? "Hoy" : "Antes"
            lblTitle.font = UIFont(name: "Avenir-Bold",
                                   size: 24)
            lblTitle.textColor = section == 0 ? UIColor.deepPurple : UIColor.gray
            aView.addSubview(lblTitle)
            return aView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if arrActivities.count == 0 {
            
            return 50
        } else if !isSearching {
            
            return 30
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return isSearching ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isSearching ? vwSearchFooter.setIsFilteringToShow(filteredItemCount: arrFilteredActivities.count, of: arrActivities.count) : vwSearchFooter.setNotFiltering()
        return isSearching ? arrFilteredActivities.count : (section == 0 ? arrTodayActivities.count : arrYesterdayActivities.count)
    }
    
    func getActivitiesForSection(section: Int)-> Int {
        
        return isSearching ? arrFilteredActivities.count : (section == 0 ? arrTodayActivities.count : arrYesterdayActivities.count)
    }
    
    func getCorresponingArrayForSection(section: Int)-> [Activity] {
        
        return isSearching ? arrFilteredActivities : (section == 0 ? arrTodayActivities : arrYesterdayActivities)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch isSearching ? arrFilteredActivities[indexPath.row].actType : getCorresponingArrayForSection(section: indexPath.section)[indexPath.row].actType {
            
        case ActivityType.newEvent:
            let aCell: NotificationEventTVCell = tableView.dequeueReusableCell(withIdentifier: "NotificationEvent", for: indexPath) as! NotificationEventTVCell
            aCell.currentNotification = isSearching ? arrFilteredActivities[indexPath.row] : getCorresponingArrayForSection(section: indexPath.section)[indexPath.row]
            aCell.layer.masksToBounds = true
            aCell.actShowNotificationEvent = {
                
                self.selectedActivity = self.isSearching ? self.arrFilteredActivities[indexPath.row] : self.getCorresponingArrayForSection(section: indexPath.section)[indexPath.row]
                self.showEvent()
            }
            return aCell
            
        case ActivityType.newFollower, ActivityType.newFollowing:
            let aCell: NotificationFollowTVCell = tableView.dequeueReusableCell(withIdentifier: "NotificationFollow", for: indexPath) as! NotificationFollowTVCell
            aCell.currentNotification = isSearching ? arrFilteredActivities[indexPath.row] : getCorresponingArrayForSection(section: indexPath.section)[indexPath.row]
            aCell.layer.masksToBounds = true
            aCell.actFollow = {
                
                aBool in
                self.selectedActivity = self.isSearching ? self.arrFilteredActivities[indexPath.row] : self.getCorresponingArrayForSection(section: indexPath.section)[indexPath.row]
                if aBool {
                    
                    self.showFollow()
                    
                } else {
                    
                    self.arrActivities = self.changeFollowType(indexPath: indexPath)
                    aCell.currentNotification = self.isSearching ? self.arrFilteredActivities[indexPath.row] : self.getCorresponingArrayForSection(section: indexPath.section)[indexPath.row]
                }
            }
            return aCell
            
        case ActivityType.newLevel:
            let aCell: NotificationBadgeTVCell = tableView.dequeueReusableCell(withIdentifier: "NotificationBadge", for: indexPath) as! NotificationBadgeTVCell
            aCell.currentNotification = isSearching ? arrFilteredActivities[indexPath.row] : getCorresponingArrayForSection(section: indexPath.section)[indexPath.row]
            aCell.layer.masksToBounds = true
            aCell.actSeeMedal = {
                
                self.performSegue(withIdentifier: "SeeMedals",
                                  sender: nil)
            }
            return aCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if isSearching && (sbActivities.text!.count > 0){
            return vwSearchFooter
        }
        return  nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if isSearching && (sbActivities.text!.count > 0){
            return 50
        }
        return 0
    }
}

//MARK: UISearchBarDelegate

extension MyActivitiesVC: UISearchBarDelegate{
    
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

extension MyActivitiesVC: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        dismissKeyboard()
    }
}

