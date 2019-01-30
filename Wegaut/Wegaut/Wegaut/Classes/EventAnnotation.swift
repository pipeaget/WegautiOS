//
//  EventAnnotation.swift
//  Wegaut
//
//  Created by Felipe Ortega on 1/29/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import MapKit

class EventAnnotation: NSObject, MKAnnotation {

    let annTitle: String?
    let annLocName: String
    let coordinate: CLLocationCoordinate2D
    
    init(aTitle: String, aLocName: String, aCoordinate: CLLocationCoordinate2D) {
        
        self.annTitle      = aTitle
        self.annLocName    = aLocName
        self.coordinate    = aCoordinate
        
        super.init()
    }
    
    var subtitle: String? {
        
        return annLocName
    }
    
}
