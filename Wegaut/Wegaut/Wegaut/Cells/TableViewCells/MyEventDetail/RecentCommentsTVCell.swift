//
//  RecentCommentsTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/12/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class RecentCommentsTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentComments: [Comment]? {
        didSet {
            drawCell()
        }
    }
    var moreCommentsAction: actMoreComments?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var imgvwUser: UIImageView!
    @IBOutlet weak var tfNewComment: UITextField!
    @IBOutlet weak var vwDividerUser: UIView!
    @IBOutlet weak var tvRecentComments: UITableView!
    @IBOutlet weak var vwDividerComments: UIView!
    @IBOutlet weak var btnMoreComments: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        vwContainer.layer.borderColor = UIColor.lightGray.cgColor
        vwContainer.layer.borderWidth = 0.5
        vwContainer.layer.masksToBounds = true
        vwContainer.cornerRadius(cornerRadius: 1)
        tvRecentComments.dataSource = self
        tvRecentComments.delegate = self
        lblComments.text = "COM_TIT".localized
        tfNewComment.placeholder = "COM_NEW".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        guard let _: [Comment] = currentComments else { return }
        tvRecentComments.rowHeight = UITableViewAutomaticDimension
        imgvwUser.cornerRadius(cornerRadius: nil)
        if let anURL = URL(string: "http://cdn02.cdn.justjared.com/wp-content/uploads/headlines/2018/03/robert-downey-jr-full-doctor-dolittle-voice-cast.jpg"){
            
            imgvwUser.sd_setImage(with: anURL,
                                  placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                  options: SDWebImageOptions.highPriority,
                                  completed: nil)
        }
        btnMoreComments.setTitle("COM_ALL".localized, for: UIControlState.normal)
        btnMoreComments.cornerRadius(cornerRadius: 5)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actViewMoreComments(_ sender: UIButton) {
        
        if let anAction = self.moreCommentsAction{
            anAction()
        }
    }
}

//MARK: - EXTENSIONS

extension RecentCommentsTVCell: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let arrComments: [Comment] = currentComments else{
            return 0
        }
        return arrComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let arrComment = currentComments else {
            
            return UITableViewCell()
        }
        let aCell: RecentCommentTVCell = tableView.dequeueReusableCell(withIdentifier: "RecentCommentCell", for: indexPath) as! RecentCommentTVCell
        aCell.currentComment = arrComment[indexPath.row]
        return aCell
    }
}
