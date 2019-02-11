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
    var currentUser: User? {
        didSet {
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
        tvRecentComments.reloadData()
    }
    
    @objc func sendComment(sender: UIButton) {
        //TODO: SEND COMMENT
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actViewMoreComments(_ sender: UIButton) {
        
        if let anAction = self.moreCommentsAction{
            anAction()
        }
    }
}

//MARK: - EXTENSIONS

extension CommentsTVCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let aView: UIView = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: screenSize.width,
                                                 height: 70))
        aView.backgroundColor = UIColor.clear
        let imgvwUser: UIImageView = UIImageView(frame: CGRect(x: 15,
                                                               y: 5,
                                                               width: 60,
                                                               height: 60))
        imgvwUser.contentMode = UIView.ContentMode.scaleAspectFit
        if let aUser = currentUser, let aURL = URL(string: aUser.usProfileImageURL) {
            
            imgvwUser.sd_setImage(with: aURL,
                                  placeholderImage: #imageLiteral(resourceName: "LGNavBar"),
                                  options: SDWebImageOptions.highPriority,
                                  completed: nil)
        } else {
            
            imgvwUser.image = #imageLiteral(resourceName: "LGNavBar")
        }
        aView.addSubview(imgvwUser)
        let aContainer: UIView = UIView(frame: CGRect(x: 80,
                                                      y: 15,
                                                      width: screenSize.width - 100,
                                                      height: 40))
        aContainer.backgroundColor = UIColor.white
        aContainer.cornerRadius(cornerRadius: 5)
        aView.addSubview(aContainer)
        let aTxtvw: UITextView = UITextView(frame: CGRect(x: 8,
                                                          y: 8,
                                                          width: aContainer.frame.width - 86,
                                                          height: 24))
        aTxtvw.backgroundColor = UIColor.clear
        aTxtvw.textColor = UIColor.lightGray
        aTxtvw.text = "SENDCOMMENT".localized
        aTxtvw.delegate = self
        aContainer.addSubview(aTxtvw)
        let aBtnSend: UIButton = UIButton(type: UIButton.ButtonType.system)
        aBtnSend.frame = CGRect(x: aContainer.frame.width - 70,
                               y: 0,
                               width: 70,
                               height: 40)
        aBtnSend.backgroundColor = UIColor.clear
        aBtnSend.setTitleColor(UIColor.deepPurple,
                               for: UIControl.State.normal)
        aBtnSend.setTitle("SEND".localized,
                          for: UIControl.State.normal)
        aContainer.addSubview(aBtnSend)
        aBtnSend.addTarget(self,
                           action: #selector(sendComment(sender:)),
                           for: UIControl.Event.touchUpInside)
        return aView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 70
    }
    
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

extension CommentsTVCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.textColor = UIColor(red: 140/255,
                                     green: 140/255,
                                     blue: 140/255,
                                     alpha: 1)
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.count == 0 || textView.text.hasPrefix("SENDPREF".localized) {
            
            textView.text = "SENDCOMMENT".localized
            textView.textColor = UIColor.lightGray
        }
    }
}
