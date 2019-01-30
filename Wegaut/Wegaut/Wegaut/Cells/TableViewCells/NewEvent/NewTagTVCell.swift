//
//  NewTagTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 12/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class NewTagTVCell: UITableViewCell {

    //MARK: - VARIABLES
    
    var arrTags: [Tag] = Tag.getTags() {
        didSet {
            cvTags.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var cvTags: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
}

extension NewTagTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (cvTags.frame.width - 40) / 3,
                      height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: NewTagCVCell = cvTags.dequeueReusableCell(withReuseIdentifier: "NewTagCell",
                                                                         for: indexPath) as! NewTagCVCell
        aCell.currentTag = arrTags[indexPath.row]
        return aCell
    }
}
