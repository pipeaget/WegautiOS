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
    
    var arrOrganizers: [Organizer] = [Organizer.getNewOrganizer()] {
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
        aCell.currentOrganizer = arrOrganizers[indexPath.row]
        aCell.layer.borderWidth = 1
        aCell.layer.borderColor = UIColor.black.cgColor
        aCell.actNewOrganizerCellAdded = {
            
            aOrganizer in
            self.arrOrganizers[indexPath.row] = aOrganizer
            self.arrOrganizers.insert(Organizer.getNewOrganizer(),
                                 at: 0)
        }
        return aCell
    }
}
