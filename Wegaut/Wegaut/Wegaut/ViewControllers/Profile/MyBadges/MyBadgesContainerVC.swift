//
//  MyBadgesContainerVC.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 3/23/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

class MyBadgesContainerVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrBadges: [Badge] = []
    var index: Int = 0 {
        didSet {
            arrBadges = Badge.getBadgesAccordingTo(badgeType: getBadgeTypeAccordingTo(index: index))
        }
    }
    
    //MARK: - OUTLETS

    @IBOutlet weak var cvBadges: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        cvBadges.reloadData()
    }
    
    func getBadgeTypeAccordingTo(index: Int) -> BadgeType {
        
        switch index {
        case 0:  return BadgeType.gold
        case 1:  return BadgeType.silver
        default: return BadgeType.bronze
        }
    }
}

//MARK: - EXTENSIONS

extension MyBadgesContainerVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrBadges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: BadgeCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BadgeCell", for: indexPath) as! BadgeCVCell
        aCell.currentBadge = arrBadges[indexPath.row]
        return aCell
    }
}
