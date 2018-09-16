//
//  DropDownTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class DropDownTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var cellOption: DropDownOption!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var ivwExpand: UIImageView!
    @IBOutlet weak var lblCellHeader: UILabel!
    @IBOutlet weak var lblCellContent: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func setupCell(aDropDownOption:DropDownOption, isExpanded:Bool){
        
        self.lblCellHeader.text = aDropDownOption.DDHeader
        self.lblCellContent.text = isExpanded ? aDropDownOption.DDContent : ""
        self.ivwExpand.image = isExpanded ? #imageLiteral(resourceName: "ICDropDown") : #imageLiteral(resourceName: "ICDropUp")
        self.ivwExpand.contentMode = UIViewContentMode.scaleAspectFit
    }
}
