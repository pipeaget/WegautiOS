//
//  NewMultimediaTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 12/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class NewMultimediaTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var arrMultimedia: [Multimedia] = [Multimedia.getDefaultMultimedia()] {
        didSet {
            cvMultimedia.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var cvMultimedia: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}

extension NewMultimediaTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cvMultimedia.frame.width / 2.7,
                      height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrMultimedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: NewMultimediaCVCell = cvMultimedia.dequeueReusableCell(withReuseIdentifier: "NewMultimediaCell",
                                                                         for: indexPath) as! NewMultimediaCVCell
        aCell.currentMultimedia = arrMultimedia[indexPath.row]
        aCell.layer.borderWidth = 1
        aCell.layer.borderColor = UIColor.black.cgColor
        aCell.actNewMultimediaCellAdded = {
            
            aMultimedia in
            self.arrMultimedia[indexPath.row] = aMultimedia
            self.arrMultimedia.insert(Multimedia.getDefaultMultimedia(),
                                      at: 0)
        }
        return aCell
    }
}
