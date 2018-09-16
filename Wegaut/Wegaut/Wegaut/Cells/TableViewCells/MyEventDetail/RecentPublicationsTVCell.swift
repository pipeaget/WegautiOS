//
//  RecentPublicationsTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/12/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class RecentPublicationsTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var arrPublications: [Publication]? {
        didSet {
            cvRecentPublications.reloadData()
        }
    }
    var selectedPublication: Publication!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblRecentPublications: UILabel!
    @IBOutlet weak var cvRecentPublications: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        lblRecentPublications.text = "RPC_RP".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }

}

extension RecentPublicationsTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrPublications!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: RecentPublicationsCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentPublicationCell", for: indexPath) as! RecentPublicationsCVCell
        aCell.currentPublication = arrPublications?[indexPath.row]
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 20) / 2,
                      height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedPublication = arrPublications![indexPath.row]
    }
}
