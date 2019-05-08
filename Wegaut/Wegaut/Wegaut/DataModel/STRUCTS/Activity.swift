//
//  Activity.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/22/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

enum activityType {
    
    //FOLLOW
    case newFollower
    case newFollowing
    
    case newLevel
    
    //EVENT
    case newEvent
    
    var description: String {
        
        switch self {
            
        case .newFollower:  return "NOT_FOLLOW".localized
        case .newFollowing: return "NOT_FLWING".localized
        case .newLevel:     return "".localized
        case .newEvent:     return "".localized
            
        }
    }
}

struct Activity {
    
    var actTitle: String
    var actType: activityType
    var actUser: User?
    var actEvent: Event?
    var actDate: String
    
    static func getNotificationFollowerType(aNotification: Activity)-> activityType {
        
        if let aUser = aNotification.actUser {
            
            if User.getFollowers().contains(where: {$0.usEmail == aUser.usEmail}) && User.getFollowing().contains(where: {$0.usEmail == aUser.usEmail}) {
                
                return activityType.newFollowing
            } else if User.getFollowers().contains(where: {$0.usEmail == aUser.usEmail}){
                
                return activityType.newFollower
            }
        } else if let _ = aNotification.actEvent {
            
            return activityType.newLevel
        }
        return activityType.newLevel
    }
    
    static func getActivities()-> [Activity] {
        
        return [Activity(actTitle: "",
                         actType: activityType.newEvent,
                         actUser: User(usName: "Emma Roberts",
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
                         actEvent: Event(eveImageURL: "https://www.videojuegosmx.com/VJMXConcurso18-V4-VJMX.png",
                                         eveName: "Concurso de videojuegos",
                                         evePlace: "Cinemex Antara",
                                         eveAddress: "Ejercito Nacional No. 843 - B Col. Granada, 11520 Miguel Hidalgo, CDMX",
                                         eveDate: "13/09/2018",
                                         eveSchedule: "03:02 PM",
                                         eveAssitantsType: AssistantType.byInvite,
                                         evePrice: "General $900 | VIP $1,250",
                                         eveDescription: "Concurso de videojuegos", eveStatus: true,
                                         eveTags: [],
                                         evePublications: Publication.getPublications(),
                                         eveComments: [],
                                         eveMultimedia: [],
                                         eveOrganizers: [Organizer(orgName: "Sony Pictures",
                                                                   orgImageURL: "N/A",
                                                                   orgLocalImage: UIImage())],
                                         eveSponsorships: [Sponsorship(spoName: "Cinemex",
                                                                       spoImageURL: "N/A",
                                                                       spoLocalImage: UIImage()),
                                                           Sponsorship(spoName: "Nike",
                                                                       spoImageURL: "N/A",
                                                                       spoLocalImage: UIImage())],
                                         eveAssistants: [],
                                         eveUserFavorited: [],
                                         eveShared: [],
                                         eveCheckIns: [],
                                         eveFollowers: []),
                         actDate: "03:02 PM | 13/09/2018"),
                Activity(actTitle: "",
                         actType: activityType.newFollower,
                         actUser: User(usName: "Emma Roberts",
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
                         actEvent: Event(eveImageURL: "Concurso de videojuegos",
                                         eveName: "Concurso de videojuegos",
                                         evePlace: "Cinemex Antara",
                                         eveAddress: "Ejercito Nacional No. 843 - B Col. Granada, 11520 Miguel Hidalgo, CDMX",
                                         eveDate: "13/09/2018",
                                         eveSchedule: "03:02 PM",
                                         eveAssitantsType: AssistantType.byInvite,
                                         evePrice: "General $900 | VIP $1,250",
                                         eveDescription: "Concurso de videojuegos", eveStatus: true,
                                         eveTags: [],
                                         evePublications: Publication.getPublications(),
                                         eveComments: [],
                                         eveMultimedia: [],
                                         eveOrganizers: [Organizer(orgName: "Sony Pictures",
                                                                   orgImageURL: "N/A",
                                                                   orgLocalImage: UIImage())],
                                         eveSponsorships: [Sponsorship(spoName: "Cinemex",
                                                                       spoImageURL: "N/A",
                                                                       spoLocalImage: UIImage()),
                                                           Sponsorship(spoName: "Nike",
                                                                       spoImageURL: "N/A",
                                                                       spoLocalImage: UIImage())],
                                         eveAssistants: [],
                                         eveUserFavorited: [],
                                         eveShared: [],
                                         eveCheckIns: [],
                                         eveFollowers: []),
                         actDate: "03:02 PM | 13/09/2018"),
                Activity(actTitle: "Master Chief Class",
                         actType: activityType.newEvent,
                         actUser: User(usName: "Emma Watson",
                                       usEmail: "example@example.com",
                                       usFirstName: "Emma",
                                       usLastNames: "Watson",
                                       usProfileImageURL: "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTQzMzAxODc2MTU3MjYxMzgz/emma-watson_gettyimages-619546914jpg.jpg",
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
                         actEvent: Event(eveImageURL: "https://news.alistguide.com.au/wp-content/uploads/2015/06/image.jpg",
                                         eveName: "Master Chief Class",
                                         evePlace: "Cinemex Antara",
                                         eveAddress: "Ejercito Nacional No. 843 - B Col. Granada, 11520 Miguel Hidalgo, CDMX",
                                         eveDate: "13/09/2018",
                                         eveSchedule: "03:02 PM",
                                         eveAssitantsType: AssistantType.byInvite,
                                         evePrice: "General $900 | VIP $1,250",
                                         eveDescription: "Master Chief Class", eveStatus: true,
                                         eveTags: [],
                                         evePublications: Publication.getPublications(),
                                         eveComments: [],
                                         eveMultimedia: [],
                                         eveOrganizers: [Organizer(orgName: "Sony Pictures",
                                                                   orgImageURL: "N/A",
                                                                   orgLocalImage: UIImage())],
                                         eveSponsorships: [Sponsorship(spoName: "Cinemex",
                                                                       spoImageURL: "N/A",
                                                                       spoLocalImage: UIImage()),
                                                           Sponsorship(spoName: "Nike",
                                                                       spoImageURL: "N/A",
                                                                       spoLocalImage: UIImage())],
                                         eveAssistants: [],
                                         eveUserFavorited: [],
                                         eveShared: [],
                                         eveCheckIns: [],
                                         eveFollowers: []),
                         actDate: "03:02 PM | 13/09/2018"),
                Activity(actTitle: "¡Felicidades!",
                         actType: activityType.newLevel,
                         actUser: User.getUserData(),
                         actEvent: nil,
                         actDate: "03:02 PM | 12/09/2018"),
                Activity(actTitle: "Concurso de videojuegos",
                         actType: activityType.newEvent,
                         actUser: User(usName: "Emma Roberts",
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
                         actEvent: Event(eveImageURL: "https://www.videojuegosmx.com/VJMXConcurso18-V4-VJMX.png",
                                         eveName: "Concurso de videojuegos",
                                         evePlace: "Cinemex Antara",
                                         eveAddress: "Ejercito Nacional No. 843 - B Col. Granada, 11520 Miguel Hidalgo, CDMX",
                                         eveDate: "13/09/2018",
                                         eveSchedule: "03:02 PM",
                                         eveAssitantsType: AssistantType.byInvite,
                                         evePrice: "General $900 | VIP $1,250",
                                         eveDescription: "Concurso de videojuegos", eveStatus: true,
                                         eveTags: [],
                                         evePublications: Publication.getPublications(),
                                         eveComments: [],
                                         eveMultimedia: [],
                                         eveOrganizers: [Organizer(orgName: "Sony Pictures",
                                                                   orgImageURL: "N/A",
                                                                   orgLocalImage: UIImage())],
                                         eveSponsorships: [Sponsorship(spoName: "Cinemex",
                                                                       spoImageURL: "N/A",
                                                                       spoLocalImage: UIImage()),
                                                           Sponsorship(spoName: "Nike",
                                                                       spoImageURL: "N/A",
                                                                       spoLocalImage: UIImage())],
                                         eveAssistants: [],
                                         eveUserFavorited: [],
                                         eveShared: [],
                                         eveCheckIns: [],
                                         eveFollowers: []),
                         actDate: "03:02 PM | 12/09/2018")]
    }
}
