//
//  FollowersVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/15/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class FollowersVC: UIViewController {
    
    enum followerType {
        
        case followers
        case following
        
        var value: Int {
            
            switch self {
                
            case .followers: return 0
                
            case .following: return 1
            }
        }
    }
    
    //MARK: - VARIABLES
    
    var displayingFollowerType: followerType = followerType.followers {
        didSet {
            tvFollowers.reloadData()
            updateThumb()
        }
    }
    var arrFollowers: [User]!
    var arrFollowing: [User]!
    var arrFiltering: [User]!
    var isSearching: Bool = false
    var rcFollowers:UIRefreshControl!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var sbFollowers: UISearchBar!
    @IBOutlet weak var tvFollowers: UITableView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var vwThumb: UIView!
    @IBOutlet weak var btnFollowers: UIButton!
    @IBOutlet weak var btnFollowing: UIButton!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        updateThumb()
        self.addImageLogoToNavBar()
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrFollowers = User.getFollowers()
        arrFollowing = User.getFollowing()
        arrFiltering = []
        
        updateThumb()
        
        sbFollowers.barTintColor = UIColor.deepPurple
        sbFollowers.placeholder = "FO_SEA".localized
        sbFollowers.delegate = self
        addRefreshToTableview()
    }
    
    //MARK: - FUNCTIONS
    
    func updateThumb() {
        
        vwThumb.frame = CGRect(x: (vwContainer.frame.width / 2) * CGFloat(displayingFollowerType.value),
                               y: vwContainer.frame.height - vwThumb.frame.height,
                               width: (vwContainer.frame.width / 2),
                               height: 3)
        
        btnFollowers.setTitle("FO_FWR".localized,
                              for: UIControl.State.normal)
        btnFollowers.setTitleColor(displayingFollowerType == followerType.followers ? UIColor.black : UIColor.lightGray,
                                   for: UIControl.State.normal)
        btnFollowing.setTitle("FO_FWG".localized,
                              for: UIControl.State.normal)
        btnFollowing.setTitleColor(displayingFollowerType == followerType.following ? UIColor.black : UIColor.lightGray,
                                   for: UIControl.State.normal)
    }
    
    @objc func getFollowers() {
        
        tvFollowers.reloadData()
        rcFollowers.endRefreshing()
    }
    
    func updateSearchResults(searchText: String) {
        
        arrFiltering = displayingFollowerType == followerType.followers ? arrFollowers.filter{$0.usName.lowercased().contains(searchText.lowercased())} : arrFollowing.filter{$0.usName.lowercased().contains(searchText.lowercased())}
        tvFollowers.reloadData()
    }
    
    /// Add Refresh Control to the table view.
    func addRefreshToTableview(){
        
        rcFollowers = UIRefreshControl()
        rcFollowers.addTarget(self,
                              action: #selector(self.getFollowers),
                              for: UIControl.Event.valueChanged)
        tvFollowers.addSubview(rcFollowers)
    }
    
    @objc func Refresh(){
        
        self.tvFollowers.reloadData()
        if self.rcFollowers != nil{
            self.rcFollowers.endRefreshing()
        }
    }

    //MARK: - ACTIONS
    
    @IBAction func actSelectSegment(_ sender: UIButton) {
        
        switch sender.tag {
            
        case 0: displayingFollowerType = followerType.followers
            
        default: displayingFollowerType = followerType.following
        }
    }
}

//MARK: - EXTENSIONS

extension FollowersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            
            return arrFiltering.count
            
        } else  {
            
            switch displayingFollowerType {
                
            case followerType.followers: return arrFollowers.count
                
            case followerType.following: return arrFollowing.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: FollowersTVCell = tableView.dequeueReusableCell(withIdentifier: "FollowersCell",
                                                                for: indexPath) as! FollowersTVCell
        return aCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let aCell = cell as! FollowersTVCell
        
        if isSearching {
            
            aCell.isFollower = displayingFollowerType == followerType.followers ? true : false
            aCell.currentFollower = arrFiltering[indexPath.row]
        } else  {
            
            switch displayingFollowerType {
                
            case followerType.followers:
                aCell.isFollower = true
                aCell.currentFollower = arrFollowers[indexPath.row]
                
            case followerType.following:
                aCell.isFollower = false
                aCell.currentFollower = arrFollowing[indexPath.row]
            }
        }
    }
}

extension FollowersVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearching = searchBar.text != "" ? true : false
        updateSearchResults(searchText: searchBar.text!)
    }
}
