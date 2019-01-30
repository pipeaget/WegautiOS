//
//  PlaceTVCell.swift
//  Wegaut
//
//  Created by Felipe Ortega on 12/11/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit
import MapKit

class PlaceTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    weak var currentPlace: MKMapItem? {
        didSet {
            drawCell()
        }
    }
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var lblPlaceName: UILabel!
    @IBOutlet weak var lblPlaceAddress: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        guard let aLocation = currentPlace else {
            
            return
        }
        self.lblPlaceName.text = aLocation.name
        self.lblPlaceAddress.text = aLocation.placemark.title
    }

}
