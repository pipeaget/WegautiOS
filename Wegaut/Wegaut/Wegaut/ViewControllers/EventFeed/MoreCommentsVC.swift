//
//  MoreCommentsVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/18/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class MoreCommentsVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var currentComments:[Comment]?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvMoreComments: UITableView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tvMoreComments.rowHeight = UITableView.automaticDimension
        self.addImageLogoToNavBar()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}

//MARK: - EXTENSIONS

extension MoreCommentsVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let arrComments = currentComments else{
            
            return 0
        }
        return arrComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: CommentTVCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTVCell
        return aCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let aCell = cell as! CommentTVCell
        guard let arrComments = currentComments else{
            return
        }
        aCell.currentComment = arrComments[indexPath.row]
    }
}
