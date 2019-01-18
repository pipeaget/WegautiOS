//
//  NewOrganizerTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 12/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class NewOrganizerTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var arrOrganizers: [Organizer] = [] {
        didSet {
            cvOrganizers.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var cvOrganizers: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}

extension NewOrganizerTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cvOrganizers.frame.width / 2.7,
                      height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrOrganizers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: NewOrganizerCVCell = cvOrganizers.dequeueReusableCell(withReuseIdentifier: "NewOrganizerCell",
                                                                         for: indexPath) as! NewOrganizerCVCell
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let aCell = cell as! NewOrganizerCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
}
