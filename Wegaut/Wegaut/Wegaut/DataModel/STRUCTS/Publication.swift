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
    }
    
    var pubType: publicationType
    var pubImage: UIImage?
    var pubVideo: String?
    var pubUrl: String?
    var pubUser: User
    var pubTitle: String
    var pubDate: Date
    
    static func getPublications() -> [Publication] {
        
        return [Publication(pubType: Publication.publicationType.photo,
                            pubImage: #imageLiteral(resourceName: "Nike"),
                            pubVideo: nil,
                            pubUrl: nil,
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
                            pubDate: Date()),
                Publication(pubType: Publication.publicationType.photo,
                            pubImage: #imageLiteral(resourceName: "Comedy"),
                            pubVideo: nil,
                            pubUrl: nil,
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
                            pubDate: Date())]
    }
}
