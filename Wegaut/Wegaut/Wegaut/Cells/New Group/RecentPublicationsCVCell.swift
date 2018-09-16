//
//  RecentPublicationsCVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/17/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class RecentPublicationsCVCell: UICollectionViewCell {
    
    //MARK: - VARIABLES
    
    var currentPublication: Publication? {
        didSet {
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwPublication: UIView!
    @IBOutlet weak var imgvwPublication: UIImageView!
    @IBOutlet weak var imgvwUserProfilePicture: UIImageView!
    @IBOutlet weak var lblPublicationTitle: UILabel!
    @IBOutlet weak var lblPubUsername: UILabel!
    @IBOutlet weak var lblPubTimelapse: UILabel!
    
    //MARK: - FUNCTIONS
    
    func drawCell() {
        
        guard let aPublication: Publication = currentPublication else { return }
        drawPhotoWith(publication: aPublication)
        switch aPublication.pubType {
            
        case .photo:
            break
            
        case .video:
            drawVideoWith(publication: aPublication)
            
        case .url:
            drawURLWith(publication: aPublication)
        }
        imgvwUserProfilePicture.cornerRadius(cornerRadius: nil)
        imgvwUserProfilePicture.sd_setImage(with: URL(string: aPublication.pubUser.usProfileImageURL),
                                            placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                            options: SDWebImageOptions.highPriority,
                                            completed: nil)
        lblPublicationTitle.adjustsFontSizeToFitWidth = true
        lblPublicationTitle.text = aPublication.pubTitle
        lblPubUsername.adjustsFontSizeToFitWidth = true
        lblPubUsername.text = aPublication.pubUser.usName
        lblPubTimelapse.adjustsFontSizeToFitWidth = true
        lblPubTimelapse.text = "\(aPublication.pubDate)"
    }
    
    func drawPhotoWith(publication: Publication) {
        
        imgvwPublication.contentMode = UIViewContentMode.scaleAspectFill
        imgvwPublication.clipsToBounds = true
        imgvwPublication.image = publication.pubImage ?? #imageLiteral(resourceName: "BGLogo")
    }
    
    func drawVideoWith(publication: Publication) {
        
    }
    
    func drawURLWith(publication: Publication) {
        
        let wvPublication: UIWebView = UIWebView(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: vwPublication.frame.width,
                                                               height: vwPublication.frame.height))
        if  let aPubStr = publication.pubUrl,
            let aPubURL = URL(string: aPubStr) {
            wvPublication.loadRequest(URLRequest(url: aPubURL))
            wvPublication.delegate = self
        }
    }
}

extension RecentPublicationsCVCell: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        imgvwPublication.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        imgvwPublication.isHidden = false
    }
}
