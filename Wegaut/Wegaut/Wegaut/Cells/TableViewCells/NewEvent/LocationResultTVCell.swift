//
//  LocationResultTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/5/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import MapKit

class LocationResultTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentLocation: MKMapItem? {
        didSet {
            updateCell()
        }
    }
    
    //MARK:: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell() {
        
        guard let aLocation = currentLocation else {
            
            return
        }
        self.textLabel?.text = aLocation.placemark.title
        self.detailTextLabel?.text = aLocation.name
    }

}
