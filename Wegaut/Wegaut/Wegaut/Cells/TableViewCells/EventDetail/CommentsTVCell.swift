//
//  CommentsTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/18/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

typealias actMoreComments = ()->Void

class CommentsTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentCommentaries: [Comment]?{
        didSet{
            drawCell()
        }
    }
    var moreCommentsAction: actMoreComments?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblComments: UILabel!
    //@IBOutlet weak var imgvwUser: UIImageView!
    //@IBOutlet weak var tfNewComment: UITextField!
    //@IBOutlet weak var vwDividerUser: UIView!
    @IBOutlet weak var tvRecentComments: UITableView!
    //@IBOutlet weak var vwDividerComments: UIView!
    @IBOutlet weak var btnMoreComments: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        tvRecentComments.dataSource = self
        tvRecentComments.delegate = self
        lblComments.text = "COM_TIT".localized
        //tfNewComment.placeholder = "COM_NEW".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        guard let _: [Comment] = currentCommentaries else{
            
            return
        }
        tvRecentComments.rowHeight = UITableView.automaticDimension
        /*imgvwUser.cornerRadius(cornerRadius: nil)
        if let anURL = URL(string: "http://cdn02.cdn.justjared.com/wp-content/uploads/headlines/2018/03/robert-downey-jr-full-doctor-dolittle-voice-cast.jpg"){
            
            imgvwUser.sd_setImage(with: anURL,
                                  placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                  options: SDWebImageOptions.highPriority,
                                  completed: nil)
        }*/
        btnMoreComments.setTitle("COM_ALL".localized, for: UIControl.State.normal)
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

extension CommentsTVCell: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let arrComments: [Comment] = currentCommentaries else{
            return 0
        }
        return arrComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let arrComment = currentCommentaries else{
            
            return UITableViewCell()
        }
        let aCell: CommentTVCell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTVCell
        aCell.currentComment = arrComment[indexPath.row]
        return aCell
    }
}
