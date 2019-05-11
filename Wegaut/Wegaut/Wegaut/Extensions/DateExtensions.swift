//
//  DateExtensions.swift
//  Wegaut
//
//  Created by Felipe Ortega Rodríguez on 5/11/19.
//  Copyright © 2019 Wegaut. All rights reserved.
//

import UIKit

extension Date {
    
    func dateToStringEddMMMyyyy()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E d MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
