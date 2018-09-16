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
    
    static func getDefaultMultimediaWith(type: MultimediaType)-> Multimedia {
        
        return Multimedia(mulMediaType: type,
                          mulImageURL: nil,
                          mulLocalImage: nil,
                          mulVideoURL: nil,
                          mulLocalVideo: nil,
                          mulURL: nil)
    }
}
