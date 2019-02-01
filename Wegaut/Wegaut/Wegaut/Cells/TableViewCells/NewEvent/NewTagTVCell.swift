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
    
    var arrTags: [Tag] = Tag.getTags()
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var cvTags: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        invertTagState()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func invertTagState() {
        
        for index in 0..<arrTags.count {
            
            arrTags[index].tagIsSelected = true
        }
    }
}

extension NewTagTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth: CGFloat = (collectionView.frame.width - 80) / 3
        return CGSize(width: cellWidth,
                      height: cellWidth)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        arrTags[indexPath.row].tagIsSelected = !arrTags[indexPath.row].tagIsSelected
        cvTags.reloadData()
    }
}
