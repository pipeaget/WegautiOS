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
    
    var description: String {
        switch self {
        case .url:   return "EVF_URL".localized
        case .image: return "EVF_IMA".localized
        case .video: return "EVF_VID".localized
        }
    }
}

struct Multimedia {
    
    var mulMediaType: MultimediaType
    var mulLocalImage: UIImage?
    var mulLocalVideo: Data?
    var mulURL: String
    var mulUser: User
    var mulDate: String
    var mulIsFavorite: Bool
    
    static func convertMultimediaToDic(_ multimedia: Multimedia)-> [String: Any] {
        
        var dicToReturn: [String: Any] = [:]
        dicToReturn["mulMediaType"] = multimedia.mulMediaType.description
        dicToReturn["mulURL"] = multimedia.mulURL
        dicToReturn["mulUser"] = User.convertUserToDic(multimedia.mulUser)
        dicToReturn["mulDate"] = multimedia.mulDate
        dicToReturn["mulIsFavorite"] = multimedia.mulIsFavorite
        return dicToReturn
    }
    
    static func convertMultimediasToDic(_ multimedia: [Multimedia])-> [String: Any] {
        
        var arrMultimedia: [[String: Any]] = [[:]]
        for multimedia in multimedia {
            arrMultimedia.append(convertMultimediaToDic(multimedia))
        }
        return ["multimedia": arrMultimedia]
    }
    
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
