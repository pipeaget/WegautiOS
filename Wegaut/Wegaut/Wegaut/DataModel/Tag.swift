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
    var tagCount: Int
    
    static func getTags()->[Tag] {
        
        return [Tag(tagName: "TAG_PAR".localized, tagCount: 0),
                Tag(tagName: "TAG_ART".localized, tagCount: 0),
                Tag(tagName: "TAG_SOC".localized, tagCount: 0),
                Tag(tagName: "TAG_COM".localized, tagCount: 0),
                Tag(tagName: "TAG_TEA".localized, tagCount: 0),
                Tag(tagName: "TAG_HAN".localized, tagCount: 0),
                Tag(tagName: "TAG_EDU".localized, tagCount: 0),
                Tag(tagName: "TAG_DAN".localized, tagCount: 0),
                Tag(tagName: "TAG_MOV".localized, tagCount: 0),
                Tag(tagName: "TAG_FIT".localized, tagCount: 0),
                Tag(tagName: "TAG_SHO".localized, tagCount: 0),
                Tag(tagName: "TAG_SPO".localized, tagCount: 0),
                Tag(tagName: "TAG_LIF".localized, tagCount: 0),
                Tag(tagName: "TAG_ENT".localized, tagCount: 0),
                Tag(tagName: "TAG_FOO".localized, tagCount: 0),
                Tag(tagName: "TAG_GAM".localized, tagCount: 0),
                Tag(tagName: "TAG_HEA".localized, tagCount: 0),
                Tag(tagName: "TAG_GAR".localized, tagCount: 0)]
    }
    
    static func getTagsForNewEvent()->[(Tag, Bool)] {
        
        return [(Tag(tagName: "TAG_PAR".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_ART".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_SOC".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_COM".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_TEA".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_HAN".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_EDU".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_DAN".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_MOV".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_FIT".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_SHO".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_SPO".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_LIF".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_ENT".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_FOO".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_GAM".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_HEA".localized, tagCount: 0), false),
                (Tag(tagName: "TAG_GAR".localized, tagCount: 0), false)]
    }
}
