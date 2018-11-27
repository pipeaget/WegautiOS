//
//  MultimediaTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/14/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class MultimediaTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentMultimedia: [Multimedia]? {
        didSet {
            updateCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblMultimedia: UILabel!
    @IBOutlet weak var cvMultimedia: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - FUNCTIONS

    func updateCell() {
        
        lblMultimedia.text = "MUL_MULT".localized
        cvMultimedia.reloadData()
    }
}

extension MultimediaTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let arrMultimedia = currentMultimedia else { return 0}
        return arrMultimedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: MultimediaCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultimediaCell",
                                                                         for: indexPath) as! MultimediaCVCell
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let arrMultimedia = currentMultimedia else { return }
        let aCell = cell as! MultimediaCVCell
        aCell.currentMultimediaFile = arrMultimedia[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cvMultimedia.frame.height * 1.5,
                      height: cvMultimedia.frame.height)
    }
}
