//
//  FollowersVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/15/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class FollowersVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrFollowers: [User]!
    var arrFollowing: [User]!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var sbFollowers: UISearchBar!
    @IBOutlet weak var ccSegConFollowers: FORSelectorDisplayer!
    @IBOutlet weak var tvFollowers: UITableView!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrFollowers = []
        arrFollowing = []
    }

}

//MARK: - EXTENSIONS

extension FollowersVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: FollowersTVCell = tableView.dequeueReusableCell(withIdentifier: "FollowersCell",
                                                                for: indexPath) as! FollowersTVCell
        return aCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let aCell = cell as! FollowersTVCell
        aCell.currentFollower = arrFollowers[indexPath.row]
    }
    
    
    
}
