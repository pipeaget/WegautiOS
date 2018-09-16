//
//  Interest.swift
//  Wegaut
//
//  Created by Felipe Ortega on 9/16/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

struct Interest {
    
    var inName: String
    var inImage: UIImage
    var inIsSelected: Bool
    
    static func getInterests() -> [Interest] {
        
        return [Interest(inName: "Sports",
                         inImage: #imageLiteral(resourceName: "ICSports"),
                         inIsSelected: false),
                Interest(inName: "Movies",
                         inImage: #imageLiteral(resourceName: "ICMovies"),
                         inIsSelected: false),
                Interest(inName: "Videogames",
                         inImage: #imageLiteral(resourceName: "ICVideogames"),
                         inIsSelected: false),
                Interest(inName: "Cars",
                         inImage: #imageLiteral(resourceName: "ICCars"),
                         inIsSelected: false),
                Interest(inName: "Food",
                         inImage: #imageLiteral(resourceName: "ICFood"),
                         inIsSelected: false),
                Interest(inName: "Music",
                         inImage: #imageLiteral(resourceName: "ICMusic"),
                         inIsSelected: false),
                Interest(inName: "World",
                         inImage: #imageLiteral(resourceName: "ICWorld"),
                         inIsSelected: false),
                Interest(inName: "Money",
                         inImage: #imageLiteral(resourceName: "ICMoney"),
                         inIsSelected: false),]
    }
}
