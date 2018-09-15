//
//  WegautConstants.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/13/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import Foundation

struct WegautConstants{
    
    //MARK: - APP META DATA INFO
    
    static let APP_VERSION                    = "CFBundleShortVersionString"
    static let BUILD_NUMER                    = "CFBundleVersion"
    
    //MARK: - CONNECTION VARIABLES
    
    static let IS_DEV_APP                     = "isOnDev"
    static let BASE_DEV_URL                   = "http://grubertek.vincoorbisdev.com/api/v1/"
    static let BASE_PROD_URL                  = "https://api.grubertek.mx/api/v1/"
    
    //MARK: -  USER STATUS
    
    static let DISPLAY_TUTORIAL               = "displayTutorial"
    static let IS_USER_LOGGED                 = "IsUserLogged"
    
    //MARK: - APP USER PERMISSIONS
    
    static let IS_PUSH_ENABLED                = "IsPushEnabled"
    static let IS_LOCATION_ENABLED            = "IsLocationEnabled"
    static let IS_CALENDAR_ENABLED            = "IsCalendarEnabled"
    
}
