//
//  Multimedia.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/20/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

enum MultimediaType {
    
    case url
    case image
    case video
}

struct Multimedia {
    
    var mulMediaType: MultimediaType
    var mulImageURL: String?
    var mulLocalImage: UIImage?
    var mulVideoURL: String?
    var mulLocalVideo: Data?
    var mulURL: String?
    var mulUser: User
    var mulDate: String
    var mulIsFavorite: Bool
    
    static func getDefaultMultimedia()-> Multimedia {
        
        return Multimedia(mulMediaType: MultimediaType.image,
                          mulImageURL: nil,
                          mulLocalImage: #imageLiteral(resourceName: "ICFollow"),
                          mulVideoURL: nil,
                          mulLocalVideo: nil,
                          mulURL: nil,
                          mulUser: User.getUserData(),
                          mulDate: "03:02 PM | 13/09/2018",
                          mulIsFavorite: false)
    }
    
    static func getMultimedia()-> [String] {
        
        return []
    }
}
