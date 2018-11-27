//
//  DropDownOption.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct DropDownOption{
    
    var DDHeader: String!
    var DDContent: String!
    
    static func getFAQ()->[DropDownOption]{
        
        return [DropDownOption(DDHeader: "DD_Q1".localized, DDContent: "DD_A1".localized),
                DropDownOption(DDHeader: "DD_Q2".localized, DDContent: "DD_A2".localized),
                DropDownOption(DDHeader: "DD_Q3".localized, DDContent: "DD_A3".localized),
                DropDownOption(DDHeader: "DD_Q4".localized, DDContent: "DD_A4".localized)]
    }
    
    static func getSoftwareLicenses()->[DropDownOption]{
        
        return [DropDownOption(DDHeader: "DD_PT1".localized, DDContent: "DD_PD1".localized),
                DropDownOption(DDHeader: "DD_PT2".localized, DDContent: "DD_PD2".localized),
                DropDownOption(DDHeader: "DD_PT3".localized, DDContent: "DD_PD3".localized),
                DropDownOption(DDHeader: "DD_PT4".localized, DDContent: "DD_PD4".localized)]
    }
}
