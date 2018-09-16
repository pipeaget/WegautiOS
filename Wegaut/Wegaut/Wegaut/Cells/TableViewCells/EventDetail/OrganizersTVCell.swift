//
//  OrganizersTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/17/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class OrganizersTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var arrOrganizers: [Organizer]?{
        didSet{
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblOrganizers: UILabel!
    @IBOutlet weak var cvOrganizers: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        vwContainer.layer.borderColor = UIColor.lightGray.cgColor
        vwContainer.layer.borderWidth = 0.5
        vwContainer.layer.masksToBounds = true
        vwContainer.cornerRadius(cornerRadius: 1)
        cvOrganizers.dataSource = self
        cvOrganizers.delegate = self
        lblOrganizers.text = "ORC_TIT".localized
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS

    func drawCell(){
        
        guard let _ = arrOrganizers else{
            return
        }
        cvOrganizers.reloadData()
    }
}

//MARK: - EXTENSIONS

extension OrganizersTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let anOrganizers = arrOrganizers else{
            
            return 0
        }
        return anOrganizers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth:CGFloat = cvOrganizers.frame.width
        return CGSize(width: (screenWidth - 20) / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: OrganizerCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrganizerCell", for: indexPath) as! OrganizerCVCell
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let aCell: OrganizerCVCell = cell as! OrganizerCVCell
        guard let anArrOrganizers = arrOrganizers else{
            return
        }
        aCell.currentOrganizer = anArrOrganizers[indexPath.row]
    }
}
