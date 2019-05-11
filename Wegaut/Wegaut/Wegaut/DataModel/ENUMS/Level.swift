//
//  Level.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/22/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

enum Level {
    
    case noob
    case medium
    case high
    
    var description: String {
        
        switch self {
            
        case Level.noob:   return "LV_1".localized
            
        case Level.medium: return "LV_2".localized
            
        case Level.high:   return "LV_3".localized
        }
    }
    
    func getLevelFromString(_ strLevel: String) -> Level {
        
        switch strLevel {
        case "NOOB":
            return Level.noob
            
        case "HALF":
            return Level.medium
            
        default:
            return Level.high
        }
    }
}
