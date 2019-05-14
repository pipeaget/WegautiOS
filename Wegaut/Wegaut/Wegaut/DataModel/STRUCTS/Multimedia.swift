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
    
    static func getMultimediaTypeFrom(_ aDescription: String)-> MultimediaType {
        switch aDescription {
        case "URL":   return MultimediaType.url
        case "Image": return MultimediaType.image
        default:      return MultimediaType.video
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
    
    static func convertDicToMultimedia(_ aDic: [String: Any])-> Multimedia? {
        
        if let aMediaType = aDic["mulMediaType"] as? String,
           let aURL = aDic["mulURL"] as? String,
            let aUserData = aDic["mulUser"] as? [String: Any],
            let aUser = User.convertDicToUser(aUserData),
            let aDate = aDic["mulDate"] as? String,
            let aFavorite = aDic["mulIsFavorite"] as? Bool {
            return Multimedia(mulMediaType: MultimediaType.getMultimediaTypeFrom(aMediaType), mulLocalImage: nil, mulLocalVideo: nil, mulURL: aURL, mulUser: aUser, mulDate: aDate, mulIsFavorite: aFavorite)
        }
        return nil
    }
    
    static func convertDicToMultimedias(_ aDic: [String: Any])-> [Multimedia] {
        
        var arrMultimedia: [Multimedia] = []
        if let multimedias = aDic["multimedia"] as? [[String: Any]] {
            for multimedia in multimedias {
                if let aMultimedia = Multimedia.convertDicToMultimedia(multimedia) {
                    arrMultimedia.append(aMultimedia)
                }
            }
            return arrMultimedia
        }
        return arrMultimedia
    }
    
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
                          mulLocalImage: #imageLiteral(resourceName: "ICFollow"),
                          mulLocalVideo: nil,
                          mulURL: "",
                          mulUser: User.getUserData(),
                          mulDate: "03:02 PM | 13/09/2018",
                          mulIsFavorite: false)
    }
    
    static func getMultimedia()-> [String] {
        
        return []
    }
}
