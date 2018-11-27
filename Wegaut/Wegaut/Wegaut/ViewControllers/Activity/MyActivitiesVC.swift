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
    
    var arrActivities: [Activity]!
    var arrFilteredActivities: [Activity]!
    var selectedActivity: Activity!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvActivities: UITableView!
    var scSearchActivities: UISearchController!
    var vwSearchFooter: FORFooterSearchResults!
    var rcActivities: UIRefreshControl!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        arrActivities = []
        arrFilteredActivities = []
        definesPresentationContext = true
        getActivities()
        self.title = "NOT_TIT".localized
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        addSearchBar()
        tvActivities.rowHeight = UITableView.automaticDimension
        tvActivities.clearsContextBeforeDrawing = true
        vwSearchFooter = FORFooterSearchResults(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        addRefreshControlToTableView()
        if #available(iOS 11.0, *){
            
            navigationItem.searchController = scSearchActivities
        }else{
            
            tvActivities.tableHeaderView = scSearchActivities.searchBar
        }
        self.addImageLogoToNavBar()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //TODO: MANAGE EACH CELL TYPE
    }
    
    //MARK: - FUNCTIONS
    
    func addSearchBar(){
        
    tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        scSearchActivities = UISearchController(searchResultsController: nil)
        scSearchActivities.searchResultsUpdater = self
        scSearchActivities.searchBar.backgroundColor = UIColor.deepPurple
        scSearchActivities.obscuresBackgroundDuringPresentation = false
        scSearchActivities.searchBar.placeholder = "EVF_SEARCH".localized
        scSearchActivities.searchBar.tintColor = UIColor.white
        scSearchActivities.searchBar.scopeButtonTitles = ["NOT_NAME".localized, "NOT_USER".localized]
        scSearchActivities.searchBar.barStyle = UIBarStyle.black
        if let textfield = scSearchActivities.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.mediumPurple
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        scSearchActivities.searchBar.delegate = self
    }
    
    @objc func getActivities(){
        
        arrActivities = Activity.getActivities()
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
    
    /// Used to validate the searchbar text.
    ///
    /// - Returns: If the text is empty returns a TRUE; otherwise a FALSE.
    func searchBarIsEmpty()->Bool{
        
        return scSearchActivities.searchBar.text?.isEmpty ?? true
    }
    
    /// Used to update the arrFilteredBanks according to the searchBar text (comparison is case sensitive).
    ///
    /// - Parameters:
    ///   - searchText: The search you want to search in the banks.
    func filterContentForSearchText(_ searchText: String, scope:String) {
        
        switch scope{
            
        case "NOT_NAME".localized:
            arrFilteredActivities = arrActivities.filter{$0.actTitle.lowercased().contains(searchText.lowercased())}
            break
            
        case "NOT_USER".localized:
            arrFilteredActivities = arrActivities.filter{User.getUserCompleteName(user: $0.actUser).lowercased().contains(searchText.lowercased())}
            break
            
        default:
            break
        }
        tvActivities.reloadData()
    }
    
    /// Used to verify if the UISearchController is active
    ///
    /// - Returns: If the UISearchController is in use returns a TRUE; otherwise FALSE.
    func isFiltering()->Bool{
        
        if scSearchActivities != nil{
            
            return scSearchActivities.isActive && !searchBarIsEmpty()
        }
        return false
    }
    
    //MARK: - ACTIONS

}

//MARK: - EXTENSIONS

extension MyActivitiesVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (arrActivities.count == 0){
            
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
        } else {
            
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
            lblTitle.text = section == 0 ? "Hoy" : "Ayer"
            lblTitle.font = UIFont(name: "Avenir-Bold",
                                   size: 24)
            lblTitle.textColor = section == 0 ? UIColor.deepPurple : UIColor.gray
            aView.addSubview(lblTitle)
            return aView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (arrActivities.count == 0){
            
            return 50
        }
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isFiltering() ? vwSearchFooter.setIsFilteringToShow(filteredItemCount: arrFilteredActivities.count, of: arrActivities.count) : vwSearchFooter.setNotFiltering()
        return isFiltering() ? arrFilteredActivities.count : arrActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch isFiltering() ? arrFilteredActivities[indexPath.row].actType : arrActivities[indexPath.row].actType {
            
        case activityType.goingEvent:
            let aCell: NotificationEventTVCell = tableView.dequeueReusableCell(withIdentifier: "NotificationEvent", for: indexPath) as! NotificationEventTVCell
            aCell.currentNotification = isFiltering() ? arrFilteredActivities[indexPath.row] : arrActivities[indexPath.row]
            aCell.layer.masksToBounds = true
            return aCell
            
        case activityType.newFollower:
            let aCell: NotificationFollowTVCell = tableView.dequeueReusableCell(withIdentifier: "NotificationFollow", for: indexPath) as! NotificationFollowTVCell
            aCell.currentNotification = isFiltering() ? arrFilteredActivities[indexPath.row] : arrActivities[indexPath.row]
            aCell.layer.masksToBounds = true
            return aCell
            
        case activityType.newLevel:
            let aCell: NotificationBadgeTVCell = tableView.dequeueReusableCell(withIdentifier: "NotificationBadge", for: indexPath) as! NotificationBadgeTVCell
            aCell.currentNotification = isFiltering() ? arrFilteredActivities[indexPath.row] : arrActivities[indexPath.row]
            aCell.layer.masksToBounds = true
            return aCell
            
        case .newFollowing:
            return UITableViewCell()
            
        case .favouritedEvent:
            return UITableViewCell()
            
        case .sharedevent:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if isFiltering() && (scSearchActivities.searchBar.text!.count > 0){
            return vwSearchFooter
        }
        return  nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if isFiltering() && (scSearchActivities.searchBar.text!.count > 0){
            return 50
        }
        return 0
    }
}

//MARK: UISearchResultsUpdating

extension MyActivitiesVC: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let scope = scSearchActivities.searchBar.scopeButtonTitles![scSearchActivities.searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(scSearchActivities.searchBar.text!.folding(options: String.CompareOptions.diacriticInsensitive, locale: Locale.current), scope: scope)
    }
}

//MARK: UISearchBarDelegate

extension MyActivitiesVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

