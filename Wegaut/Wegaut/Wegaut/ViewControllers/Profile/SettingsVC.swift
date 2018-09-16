//
//  SettingsVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import MessageUI

class SettingsVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var selectedSettingsOption: SettingsOption?
    var dropDownType: DropDownType?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvSettings: UITableView!
    
    //MARK: - VIEW LIFECYCLE

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tvSettings.dataSource = self
        tvSettings.delegate = self
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? SimpleDetailVC,
            let currentSettingsOption = selectedSettingsOption{
            
            destinationVC.currentSettingOption = currentSettingsOption
        }
        
        if let destinationVC = segue.destination as? DropDownDetailVC,
            let currentDropDownType = dropDownType{
            
            destinationVC.currentInfoType = currentDropDownType
        }
    }
}

//MARK: - EXTENSIONS

//MARK: - UITableViewDataSource & UITableViewDelegate

extension SettingsVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        let vwHeader: UIView = UIView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenSize.width,
                                                    height: 50))
        let lblHeader: UILabel = UILabel(frame: CGRect(x: 10,
                                                       y: 10,
                                                       width: screenSize.width - 20,
                                                       height: 30))
        lblHeader.text = SettingsOption.getSectionName(accordingTo: section)
        lblHeader.textColor = UIColor.white
        lblHeader.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        vwHeader.backgroundColor = UIColor.deepPurple
        vwHeader.addSubview(lblHeader)
        return vwHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return SettingsOption.getSections().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let aSection = SettingsOption.getSections()[SettingsOption.getSectionName(accordingTo: section)]{
            return aSection.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell:SettingsTVCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell",
                                                             for: indexPath) as! SettingsTVCell
        return aCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let aCell = cell as! SettingsTVCell
        if let aSection = SettingsOption.getSections()[SettingsOption.getSectionName(accordingTo: indexPath.section)]{
            
            aCell.cellSection = aSection[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let aSection = SettingsOption.getSections()[SettingsOption.getSectionName(accordingTo: indexPath.section)]{
            
            let cellHeight = SettingsTVCell.getCellHeightAccordingTo(aSettingsOption: aSection[indexPath.row])
            return  cellHeight < 50 ? 50 : cellHeight
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let aSettingsOption:SettingsTVCell = tableView.cellForRow(at: indexPath) as? SettingsTVCell,
            let aCellSection:SettingsOption = aSettingsOption.cellSection{
            
            switch aCellSection.SODestinationType{
                
            case destinationType.noDestination:
                break
                
            case destinationType.editProfile:
                self.performSegue(withIdentifier: "showEditProfile", sender: self)
                
            case destinationType.closeSession:
                let popUpAlert:FORPopUpView = FORPopUpView(with: FORAlertData(yesNoAlert: nil,
                                                                              aTitle: "CS_TITLE".localized,
                                                                              aMessage: "CS_MSSG".localized,
                                                                              yesButtonTitle: "YES".localized,
                                                                              yesButtonColor: UIColor.deepPurple,
                                                                              noButtonTitle: "NO".localized,
                                                                              noButtonColor: UIColor.mediumPurple))
                popUpAlert.yesNoSuccess = {
                    
                    success in
                    if success{
                        popUpAlert.dismiss(animated: true)
                        UserDefaults.standard.set(false, forKey: WegautConstants.IS_USER_LOGGED)
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main",
                                                                    bundle: nil)
                        let tabBar = storyBoard.instantiateViewController(withIdentifier: "RootNavigation") as! UITabBarController
                        self.present(tabBar,
                                     animated:true,
                                     completion:nil)
                    }else{
                        
                        popUpAlert.dismiss(animated: true)
                    }
                }
                popUpAlert.show(animated: true)
                
            case destinationType.simpleDetail:
                selectedSettingsOption = aCellSection
                self.performSegue(withIdentifier: "showSimpleDetail", sender: self)
                
            case destinationType.contact:
                if (MFMailComposeViewController.canSendMail()){
                    
                    let mailComposeVC = configureEmailComposeVC()
                    self.present(mailComposeVC,
                                 animated: true,
                                 completion: {
                        let navAppearance = UINavigationBar.appearance()
                        navAppearance.barTintColor = UIColor.black
                        navAppearance.tintColor = UIColor.lightGray
                        navAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
                                                             NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20)]
                    })
                }else{
                    
                    self.showEmailErrorAlert()
                }
                
            case destinationType.dropDownDetail:
                switch aCellSection.SOTitle{
                    
                case "SO_FAQ".localized:
                    dropDownType = DropDownType.FAQ
                    
                case "SO_SL".localized:
                    dropDownType = DropDownType.SoftwareLicenses
                    
                default:
                    break
                }
                self.performSegue(withIdentifier: "showDropDownDetail", sender: self)
                
            }
        }
    }
}

//MARK: - MFMailComposeViewControllerDelegate

extension SettingsVC:MFMailComposeViewControllerDelegate{
    
    func configureEmailComposeVC()->MFMailComposeViewController{
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["development@wegaut.com"])
        mailComposerVC.setSubject("MF_SUB".localized)
        mailComposerVC.setMessageBody("MF_BOD".localized, isHTML: false)
        return mailComposerVC
    }
    
    func showEmailErrorAlert(){
        
        self.navigationItem.setLeftBarButton(nil, animated: false)
        
        let popUpAlert: FORPopUpView = FORPopUpView(with: FORAlertData(okAlert: nil,
                                                                      aTitle: "MF_ERR_TIT".localized,
                                                                      aMessage: "MF_ERR_MESS".localized,
                                                                      okButtonTitle: "MF_OK_TIT".localized,
                                                                      okButtonColor: UIColor.red))
        popUpAlert.yesNoSuccess = {
            
            success in
            if success{
                
                popUpAlert.dismiss(animated: true)
            }
        }
        popUpAlert.show(animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}

