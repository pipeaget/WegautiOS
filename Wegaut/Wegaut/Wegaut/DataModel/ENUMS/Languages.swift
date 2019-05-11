//
//  Languages.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 5/11/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

enum Language {
    
    case spanish
    case english
    
    var languageCode: String {
        switch self {
        case Language.spanish: return "es"
        case Language.english: return "en"
        }
    }
    
    var languageTableName: String {
        switch self {
        case .spanish: return "Spanish"
        case .english: return "English"
        }
    }
}
