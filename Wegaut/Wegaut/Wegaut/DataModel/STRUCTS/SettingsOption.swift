//
//  SettingsOption.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

enum cellType{
    
    case pushNotifications
    case detailDisclosure
    
    var accessoryType: UITableViewCell.AccessoryType{
        
        switch self {
            
        case cellType.detailDisclosure:
            return UITableViewCell.AccessoryType.disclosureIndicator
            
        default:
            return UITableViewCell.AccessoryType.none
        }
    }
}

enum destinationType{
    
    case noDestination
    case editProfile
    case closeSession
    case simpleDetail
    case dropDownDetail
    case contact
}

struct SettingsOption{
    
    var SOCellType: cellType!
    var SOTitle: String!
    var SODestinationType:destinationType
    
    static func getSections()->[String: [SettingsOption]]{
        
        return ["SO_H1".localized: [SettingsOption(SOCellType: cellType.pushNotifications,
                                                   SOTitle: "SO_PN".localized,
                                                   SODestinationType: destinationType.noDestination)],
                "SO_H2".localized: [SettingsOption(SOCellType: cellType.detailDisclosure,
                                                   SOTitle: "SO_EP".localized,
                                                   SODestinationType: destinationType.editProfile),
                                    SettingsOption(SOCellType: cellType.detailDisclosure,
                                                   SOTitle: "SO_CS".localized,
                                                   SODestinationType: destinationType.closeSession)],
                "SO_H3".localized: [SettingsOption(SOCellType: cellType.detailDisclosure,
                                                   SOTitle: "SO_AU".localized,
                                                   SODestinationType: destinationType.simpleDetail),
                                    SettingsOption(SOCellType: cellType.detailDisclosure,
                                                   SOTitle: "SO_CON".localized,
                                                   SODestinationType: destinationType.contact)],
                "SO_H4".localized: [SettingsOption(SOCellType: cellType.detailDisclosure,
                                                   SOTitle: "SO_T&C".localized,
                                                   SODestinationType: destinationType.simpleDetail),
                                    SettingsOption(SOCellType: cellType.detailDisclosure,
                                                   SOTitle: "SO_PA".localized,
                                                   SODestinationType: destinationType.simpleDetail),
                                    SettingsOption(SOCellType: cellType.detailDisclosure,
                                                   SOTitle: "SO_FAQ".localized,
                                                   SODestinationType: destinationType.dropDownDetail),
                                    SettingsOption(SOCellType: cellType.detailDisclosure,
                                                   SOTitle: "SO_SL".localized,
                                                   SODestinationType: destinationType.dropDownDetail)]]
    }
    
    static func getSectionName(accordingTo index:Int)->String{
        
        switch index {
            
        case 0:
            return "SO_H1".localized
            
        case 1:
            return "SO_H2".localized
            
        case 2:
            return "SO_H3".localized
            
        default:
            return "SO_H4".localized
        }
    }
}
