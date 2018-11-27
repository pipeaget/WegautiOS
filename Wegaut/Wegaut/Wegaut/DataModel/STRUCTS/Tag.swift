//
//  Tag.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct Tag {
    
    var tagName: String
    var tagImage: UIImage
    var tagIsSelected: Bool
    
    static func getTags()->[Tag] {
        
        return [Tag(tagName: "TAG_PAR".localized,
                    tagImage: #imageLiteral(resourceName: "TAGCars"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_ART".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_SOC".localized,
                    tagImage: #imageLiteral(resourceName: "TAGWorld"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_COM".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_TEA".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_HAN".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_EDU".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_DAN".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_MOV".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMovies"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_FIT".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_SHO".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_SPO".localized,
                    tagImage: #imageLiteral(resourceName: "TAGSports"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_LIF".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMoney"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_ENT".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_FOO".localized,
                    tagImage: #imageLiteral(resourceName: "TAGFood"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_GAM".localized,
                    tagImage: #imageLiteral(resourceName: "TAGVideogames"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_HEA".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false),
                Tag(tagName: "TAG_GAR".localized,
                    tagImage: #imageLiteral(resourceName: "TAGMusic"),
                    tagIsSelected: false)]
    }
}
