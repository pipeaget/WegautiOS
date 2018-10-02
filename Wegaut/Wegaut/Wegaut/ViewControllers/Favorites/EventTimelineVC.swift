//
//  EventTimelineVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/5/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class EventTimelineVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var currentEvent: Event?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvEventTimeLine: UITableView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showAllComments" {
            
            let destinationVC: MoreCommentsVC = segue.destination as! MoreCommentsVC
            destinationVC.currentComments = Comment.getcomments()
        }
    }
}

//MARK: - EXTENSIONS

//MARK: UITableViewDataSource & UITableViewDelegate

extension EventTimelineVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let aView: UIView = UIView(frame: CGRect(x: 2,
                                                 y: 0,
                                                 width: screenSize.width - 4,
                                                 height: 70))
        aView.backgroundColor = UIColor.white
        let lblEventName: UILabel = UILabel(frame: CGRect(x: 10,
                                                          y: 5,
                                                          width: screenSize.width - 120,
                                                          height: 30))
        lblEventName.adjustsFontSizeToFitWidth = true
        lblEventName.font = UIFont.systemFont(ofSize: 30,
                                              weight: UIFont.Weight.bold)
        lblEventName.textColor = UIColor.black
        lblEventName.text = currentEvent?.eveName ?? ""
        aView.addSubview(lblEventName)
        let lblEventSponsorships: UILabel = UILabel(frame: CGRect(x: 10,
                                                                  y: 40,
                                                                  width: screenSize.width - 120,
                                                                  height: 20))
        lblEventSponsorships.adjustsFontSizeToFitWidth = true
        lblEventSponsorships.font = UIFont.systemFont(ofSize: 16,
                                                      weight: UIFont.Weight.light)
        lblEventSponsorships.textColor = UIColor.gray
        var strOragnizers: String = ""
        for sponsorship in currentEvent?.eveSponsorships ?? [] {
            
            strOragnizers.append("\(sponsorship.spoName), ")
        }
        lblEventSponsorships.text = String(strOragnizers.dropLast(2))
        aView.addSubview(lblEventSponsorships)
        let imgvwOrganizer: UIImageView = UIImageView(frame: CGRect(x: screenSize.width - 120,
                                                                    y: 5,
                                                                    width: 120,
                                                                    height: 60))
        imgvwOrganizer.contentMode = UIView.ContentMode.scaleAspectFit
        imgvwOrganizer.sd_setImage(with: URL(string: (currentEvent?.eveOrganizers.first?.orgImageURL)!),
                                   placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                   options: SDWebImageOptions.highPriority,
                                   completed: nil)
        aView.addSubview(imgvwOrganizer)
        return aView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return 250
            
        case 1:
            return 200
            
        default:
            return 420
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let aCell: RecentPublicationsTVCell = tableView.dequeueReusableCell(withIdentifier: "RecentPublicationCell", for: indexPath) as! RecentPublicationsTVCell
            aCell.arrPublications = currentEvent?.evePublications ?? []
            return aCell
            
        case 1:
            let aCell: MainInfoTVCell = tableView.dequeueReusableCell(withIdentifier: "MainInfoCell", for: indexPath) as! MainInfoTVCell
            return aCell
            
        default:
            let aCell: RecentCommentsTVCell = tableView.dequeueReusableCell(withIdentifier: "RecentCommentsCell", for: indexPath) as! RecentCommentsTVCell
            aCell.moreCommentsAction = {
                
                self.performSegue(withIdentifier: "showAllComments",
                                  sender: self)
            }
            return aCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            let aCell: RecentPublicationsTVCell = cell as! RecentPublicationsTVCell
            aCell.arrPublications = currentEvent?.evePublications
            
        case 1:
            let aCell: MainInfoTVCell = cell as! MainInfoTVCell
            aCell.currentEvent = currentEvent
            
        default:
            let aCell: RecentCommentsTVCell = cell as! RecentCommentsTVCell
            aCell.currentComments = Comment.getcomments()
        }
    }
}
