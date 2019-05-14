//
//  Publication.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct Publication {
    
    enum publicationType {
        
        case photo
        case video
        case url
        
        var description: String {
            switch self {
            case .photo: return "EVF_PHO".localized
            case .video: return "EVF_VID".localized
            case .url:   return "EVF_URL".localized
            }
        }
    }
    
    var pubType: publicationType
    var pubImage: UIImage?
    var pubVideo: String?
    var pubUrl: String
    var pubUser: User
    var pubTitle: String
    var pubDate: String
    
    static func getPublicationTypeFrom(_ strPublicationType: String) -> publicationType {
        switch strPublicationType {
        case "Photo": return publicationType.photo
        case "Video": return publicationType.video
        default:      return publicationType.url
        }
    }
    
    static func convertDicToPublication(_ aDic: [String: Any])-> Publication? {
        
        if let aPubType = aDic["pubType"] as? String,
           let aPubURL = aDic["pubUrl"] as? String,
           let aPubUser = aDic["pubUser"] as? [String: Any],
           let aUser = User.convertDicToUser(aPubUser),
           let aPubTitle = aDic["pubTitle"] as? String,
           let aPubDate = aDic["pubDate"] as? String {
            
            return Publication(pubType: Publication.getPublicationTypeFrom(aPubType), pubImage: nil, pubVideo: nil, pubUrl: aPubURL, pubUser: aUser, pubTitle: aPubTitle, pubDate: aPubDate)
        } else {
            return nil
        }
    }
    
    static func convertDicToPublications(_ aDic: [String:Any])-> [Publication] {
        
        var arrPublications: [Publication] = []
        if let aPublications = aDic["publications"] as? [[String: Any]] {
            for publication in aPublications {
                if let aPublication = Publication.convertDicToPublication(publication) {
                    arrPublications.append(aPublication)
                }
                return arrPublications
            }
        }
        return arrPublications
    }
    
    static func convertPublicationToDic(_ publication: Publication)-> [String: Any] {
        
        var dicToReturn: [String: Any] = [:]
        dicToReturn["pubType"] = publication.pubType.description
        dicToReturn["pubUrl"]  = publication.pubUrl
        dicToReturn["pubUser"] = User.convertUserToDic(publication.pubUser)
        dicToReturn["pubTitle"] = publication.pubTitle
        dicToReturn["pubDate"] = publication.pubDate
        return dicToReturn
    }
    
    static func convertPublicationsToDic(_ publications: [Publication])-> [String: Any] {
        
        var arrPublications: [[String: Any]] = [[:]]
        for publication in publications {
            arrPublications.append(convertPublicationToDic(publication))
        }
        return ["publications": arrPublications]
    }
    
    static func getPublications() -> [Publication] {
        
        return [Publication(pubType: Publication.publicationType.photo,
                            pubImage: #imageLiteral(resourceName: "Nike"),
                            pubVideo: nil,
                            pubUrl: "",
                            pubUser: User(usId: "", usName: "Emma Roberts",
                                          usEmail: "example@example.com",
                                          usFirstName: "Emma",
                                          usLastNames: "Roberts",
                                          usProfileImageURL: "https://m.media-amazon.com/images/M/MV5BMTQ4Njg2NTA4MF5BMl5BanBnXkFtZTgwNjAxNjQ0MDI@._V1_.jpg",
                                          usProfileImage: UIImage(),
                                          usBirthdate: "",
                                          usPassword: "",
                                          usDescription: "Lorem ipsum",
                                          usWegautLevel: Level.noob,
                                          usFollowers: [],
                                          usFollowing: [],
                                          usCreatedEvents: [],
                                          usAssistingEvents: [],
                                          usFavouriteEvents: [],
                                          usSharedEvents: [],
                                          usActivities: [],
                                          usTags: []),
                            pubTitle: "¡Increíble!",
                            pubDate: ""),
                Publication(pubType: Publication.publicationType.photo,
                            pubImage: #imageLiteral(resourceName: "Comedy"),
                            pubVideo: nil,
                            pubUrl: "",
                            pubUser: User(usId: "", usName: "Emma Roberts",
                                          usEmail: "example@example.com",
                                          usFirstName: "Emma",
                                          usLastNames: "Roberts",
                                          usProfileImageURL: "https://m.media-amazon.com/images/M/MV5BMTQ4Njg2NTA4MF5BMl5BanBnXkFtZTgwNjAxNjQ0MDI@._V1_.jpg",
                                          usProfileImage: UIImage(),
                                          usBirthdate: "",
                                          usPassword: "",
                                          usDescription: "Lorem ipsum",
                                          usWegautLevel: Level.noob,
                                          usFollowers: [],
                                          usFollowing: [],
                                          usCreatedEvents: [],
                                          usAssistingEvents: [],
                                          usFavouriteEvents: [],
                                          usSharedEvents: [],
                                          usActivities: [],
                                          usTags: []),
                            pubTitle: "¡Increíble!",
                            pubDate: "")]
    }
}
