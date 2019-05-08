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
    
    var arrInterests: [Tag]! {
        didSet{
            cvInterests.reloadData()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var lblInstructions: UILabel!
    @IBOutlet weak var cvInterests: UICollectionView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrInterests = Tag.getTags()
        lblInstructions.text = "SEL_TIT".localized
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    func goToFeed() {
        
        UserDefaults.standard.set(true,
                                  forKey: WegautConstants.IS_USER_LOGGED)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main",
                                                    bundle: nil)
        let tabBar = storyBoard.instantiateViewController(withIdentifier: "RootNavigation") as! UITabBarController
        self.present(tabBar,
                     animated:true,
                     completion:nil)
    }
    
    //MARK: - ACTIONS
    
    @IBAction func actDismiss(_ sender: UIButton) {
        
        goToFeed()
    }

    @IBAction func actConfirmInterests(_ sender: UIButton) {
        
        goToFeed()
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

      if UIScreen.main.traitCollection.userInterfaceIdiom == .phone {
        let cellSize:CGFloat = (cvInterests.frame.width - 20) / 2
        return CGSize(width: cellSize, height: cellSize)
      } else {
        let cellSize:CGFloat = (cvInterests.frame.width - 40) / 4
        return CGSize(width: cellSize, height: cellSize)
      }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0,
                            left: 0,
                            bottom: (collectionView.frame.height - (((cvInterests.frame.width - 20) / 2) * 4)) / 3,
                            right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        arrInterests[indexPath.row].tagIsSelected = !arrInterests[indexPath.row].tagIsSelected
        cvInterests.reloadData()
    }
}
