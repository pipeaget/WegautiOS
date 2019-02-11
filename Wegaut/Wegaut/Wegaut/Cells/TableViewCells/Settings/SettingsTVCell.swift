//
//  SettingsTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class SettingsTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var cellSection: SettingsOption?{
        didSet{
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    var lblTitle: UILabel!
    var swPushNotifications: UISwitch?
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected,
                          animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        
        guard let currentCellSection = cellSection else{
            return
        }
        let screenSize: CGSize = UIScreen.main.bounds.size
        let cellHeight: CGFloat = SettingsTVCell.getCellHeightAccordingTo(aSettingsOption: currentCellSection)
        
        lblTitle = UILabel(frame: CGRect(x: 10,
                                         y: 10,
                                         width: currentCellSection.SOCellType.accessoryType == UITableViewCell.AccessoryType.none ? screenSize.width - 53 : screenSize.width - 69,
                                         height: (cellHeight >= 50 ? cellHeight : 50) - 20))
        lblTitle.text = currentCellSection.SOTitle
        lblTitle.font = UIFont(name: "Avenir-Medium",
                               size: 16) ?? UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        lblTitle.textColor = UIColor.black
        lblTitle.numberOfLines = 0
        if !(lblTitle!.parentViewController != nil) {
            
            self.contentView.addSubview(lblTitle)
        }
        
        self.accessoryType = currentCellSection.SOCellType.accessoryType
        
        if currentCellSection.SOCellType == cellType.pushNotifications{
            
            swPushNotifications = UISwitch(frame: CGRect(x: screenSize.width - 59,
                                                         y: ((cellHeight < 50 ? 50 : cellHeight) - 31) / 2,
                                                         width: 39,
                                                         height: 31))
            swPushNotifications!.isOn = UserDefaults.standard.bool(forKey: WegautConstants.IS_PUSH_ENABLED)
            swPushNotifications!.onTintColor = UIColor.deepPurple
            self.accessoryView = swPushNotifications
        }else{
            
            self.accessoryView = UIImageView(image: #imageLiteral(resourceName: "ICDetailDisclosure"))
            self.accessoryView?.contentMode = UIView.ContentMode.scaleAspectFit
        }
    }
    
    /// Used to obtain the corresponding height according to the SettingsOption struct properties.
    ///
    /// - Parameter aSettingsOption: The corresponding SettingsOption you want to display.
    /// - Returns: The corresponding cell height needed to display the info.
    static func getCellHeightAccordingTo(aSettingsOption:SettingsOption)->CGFloat{
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        let attrName:NSAttributedString = NSAttributedString(string: aSettingsOption.SOTitle,
                                                             attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)])
        let rectTitle:CGRect = attrName.boundingRect(with: CGSize(width: (screenSize.width - (aSettingsOption.SOCellType.accessoryType == UITableViewCell.AccessoryType.none ? screenSize.width - 53 : screenSize.width - 69)),
                                                                  height: CGFloat.greatestFiniteMagnitude),
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     context: nil)
        return rectTitle.height + 20
    }
}
