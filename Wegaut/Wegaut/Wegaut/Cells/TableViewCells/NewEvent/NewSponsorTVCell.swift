//
//  NewSponsorTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 12/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class NewSponsorTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var arrSponsors: [Sponsorship] = [Sponsorship.getNewSponsor()] {
        didSet {
            cvSponsors.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var cvSponsors: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}

extension NewSponsorTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cvSponsors.frame.width / 2.7,
                      height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrSponsors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: NewSponsorCVCell = cvSponsors.dequeueReusableCell(withReuseIdentifier: "NewSponsorCell",
                                                                         for: indexPath) as! NewSponsorCVCell
        aCell.currentSponsor = arrSponsors[indexPath.row]
        aCell.layer.borderWidth = 1
        aCell.layer.borderColor = UIColor.black.cgColor
        return aCell
    }
}
