//
//  Activity.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/22/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

enum ActivityType {
    
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
        case .newLevel:     return "NOT_NEWLVL".localized
        case .newEvent:     return "NOT_NEWEV".localized
        }
    }
    
    static func getActivityTypeFrom(_ aDescription: String)-> ActivityType {
        switch aDescription {
        case "Follow":    return ActivityType.newFollower
        case "Following": return ActivityType.newFollowing
        case "New Level": return ActivityType.newLevel
        default:          return ActivityType.newEvent
        }
    }
}

struct Activity {
    
    var actTitle: String
    var actType: ActivityType
    var actUser: User?
    var actEvent: Event?
    var actDate: String
    
    static func convertDicToActivity(_ aDic: [String: Any])-> Activity? {
        
        if let aTitle = aDic[""] as? String,
            let aType = aDic[""] as? String,
            let aUserData = aDic[""] as? [String: Any],
            let aUser = User.convertDicToUser(aUserData),
            let anEventData = aDic[""] as? [String: Any],
            let anEvent = Event.convertDicToEvent(anEventData),
            let aDate = aDic[""] as? String {
            
            return Activity(actTitle: aTitle, actType: ActivityType.getActivityTypeFrom(aType), actUser: aUser, actEvent: anEvent, actDate: aDate)
        }
        return nil
    }
    
    static func convertDicToActivities(_ aDic: [String: Any])-> [Activity] {
        
        var arrActivities: [Activity] = []
        if let activities = aDic["activities"] as? [[String: Any]] {
            for activity in activities {
                if let anActivity = Activity.convertDicToActivity(activity) {
                    arrActivities.append(anActivity)
                }
            }
            return arrActivities
        }
        return arrActivities
    }
    
    static func convertActivityToDic(_ activity: Activity)-> [String: Any] {
        
        var dicToReturn: [String: Any] = [:]
        dicToReturn["actTitle"] = activity.actTitle
        dicToReturn["actType"] = activity.actType.description
        if let anUser = activity.actUser {
            dicToReturn["actUser"] = User.convertUserToDic(anUser)
        }
        if let anEvent = activity.actEvent {
            dicToReturn["actEvent"] = Event.convertEventToDic(anEvent)
        }
        dicToReturn["actDate"] = activity.actDate
        return dicToReturn
    }
    
    static func convertActivitiesToDic(_ activities: [Activity])-> [String: Any] {
        
        var dicToReturn: [[String: Any]] = [[:]]
        for activity in activities {
            dicToReturn.append(Activity.convertActivityToDic(activity))
        }
        return ["activities": dicToReturn]
    }
    
    static func getNotificationFollowerType(aNotification: Activity)-> ActivityType {
        
        if let aUser = aNotification.actUser {
            
            if User.getFollowers().contains(where: {$0.usEmail == aUser.usEmail}) && User.getFollowing().contains(where: {$0.usEmail == aUser.usEmail}) {
                
                return ActivityType.newFollowing
            } else if User.getFollowers().contains(where: {$0.usEmail == aUser.usEmail}){
                
                return ActivityType.newFollower
            }
        } else if let _ = aNotification.actEvent {
            
            return ActivityType.newLevel
        }
        return ActivityType.newLevel
    }
    
    static func getActivities()-> [Activity] {
        
        return [Activity(actTitle: "",
                         actType: ActivityType.newEvent,
                         actUser: User(usId: "", usName: "Emma Roberts",
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
                                         eveUsersShared: [],
                                         eveUsersCheckIns: [],
                                         eveUsersFollowers: []),
                         actDate: "03:02 PM | 13/09/2018"),
                Activity(actTitle: "",
                         actType: ActivityType.newFollower,
                         actUser: User(usId: "", usName: "Emma Roberts",
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
                                         eveUsersShared: [],
                                         eveUsersCheckIns: [],
                                         eveUsersFollowers: []),
                         actDate: "03:02 PM | 13/09/2018"),
                Activity(actTitle: "Master Chief Class",
                         actType: ActivityType.newEvent,
                         actUser: User(usId: "", usName: "Emma Watson",
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
                                         eveUsersShared: [],
                                         eveUsersCheckIns: [],
                                         eveUsersFollowers: []),
                         actDate: "03:02 PM | 13/09/2018"),
                Activity(actTitle: "¡Felicidades!",
                         actType: ActivityType.newLevel,
                         actUser: User.getUserData(),
                         actEvent: nil,
                         actDate: "03:02 PM | 12/09/2018"),
                Activity(actTitle: "Concurso de videojuegos",
                         actType: ActivityType.newEvent,
                         actUser: User(usId: "", usName: "Emma Roberts",
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
                                         eveUsersShared: [],
                                         eveUsersCheckIns: [],
                                         eveUsersFollowers: []),
                         actDate: "03:02 PM | 12/09/2018")]
    }
}
