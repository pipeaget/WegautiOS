//
//  Activity.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/22/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

enum activityType {
    
    case newFollower
    case newFollowing
    case newLevel
    case favouritedEvent
    case goingEvent
    case sharedevent
}

struct Activity {
    
    var actTitle: String
    var actType: activityType
    var actUser: User
    var actEvent: Event
    var actDate: Date
    
    static func getActivities()-> [Activity] {
        
        return [Activity(actTitle: "",
                         actType: activityType.goingEvent,
                         actUser: User(usName: "Emma Roberts",
                                       usEmail: "example@example.com",
                                       usFirstName: "Emma",
                                       usFathersLastName: "Roberts",
                                       usMothersLastName: "Perez",
                                       usProfileImageURL: "https://m.media-amazon.com/images/M/MV5BMTQ4Njg2NTA4MF5BMl5BanBnXkFtZTgwNjAxNjQ0MDI@._V1_.jpg",
                                       usBirthdate: Date(),
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
                         actEvent: Event(eveImageURL: "Sicario",
                                         eveName: "Sicario 2, Alfombra Roja",
                                         evePlace: "Cinemex Antara",
                                         eveAddress: "Ejercito Nacional No. 843 - B Col. Granada, 11520 Miguel Hidalgo, CDMX",
                                         eveDate: "Lunes 11 de Junio de 2018",
                                         eveSchedule: "7 pm - 9pm",
                                         eveAssitantsType: AssistantType.byInvite,
                                         evePrice: "General $900 | VIP $1,250",
                                         eveDescription: "Premier Sicario 2", eveStatus: true,
                                         eveTags: [],
                                         eveAssitants: [],
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
                         actDate: Date())]
    }
}
