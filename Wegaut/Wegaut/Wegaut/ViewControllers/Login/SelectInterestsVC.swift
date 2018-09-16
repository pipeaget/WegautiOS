//
//  SelectInterestsVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/16/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

class SelectInterestsVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var arrInterests: [Interest]! {
        didSet{
            cvInterests.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var lblInstructions: UILabel!
    @IBOutlet weak var cvInterests: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrInterests = Interest.getInterests()
        lblInstructions.text = "SEL_TIT".localized
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    //MARK: - ACTIONS
    
    @IBAction func actDismiss(_ sender: UIButton) {
        
        UserDefaults.standard.set(true,
                                  forKey: WegautConstants.IS_USER_LOGGED)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main",
                                                    bundle: nil)
        let tabBar = storyBoard.instantiateViewController(withIdentifier: "RootNavigation") as! UITabBarController
        self.present(tabBar,
                     animated:true,
                     completion:nil)
    }

}

extension SelectInterestsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrInterests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aCell: InterestCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell",
                                                                       for: indexPath) as! InterestCVCell
        aCell.currentInterest = arrInterests[indexPath.row]
        return aCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSize:CGFloat = (cvInterests.frame.width - 20) / 2
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0,
                            left: 0,
                            bottom: (collectionView.frame.height - (((cvInterests.frame.width - 20) / 2) * 4)) / 3,
                            right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        arrInterests[indexPath.row].inIsSelected = !arrInterests[indexPath.row].inIsSelected
        cvInterests.reloadData()
    }
}
