//
//  Event.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/11/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

enum AssistantType: String {
    
    case forAll
    case forPublic
    case byTicket
    case byInvite
    
    var description: String {
        
        switch self {
            
        case AssistantType.forAll: return "ASS_ALL".localized
            
        case AssistantType.forPublic: return "ASS_PUB".localized
            
        case AssistantType.byInvite: return "ASS_INV".localized
            
        case AssistantType.byTicket: return "ASS_TIC".localized
        }
    }
    
    static func getAllAsistantTypes()-> [String] {
        
        return [AssistantType.forAll.description,
                AssistantType.forPublic.description,
                AssistantType.byTicket.description,
                AssistantType.byInvite.description]
    }
    
    static func getAssistantTypeFrom(index: Int)-> AssistantType {
        
        switch index {
            
        case 0:  return AssistantType.forAll
        case 1:  return AssistantType.forPublic
        case 2:  return AssistantType.byTicket
        default: return AssistantType.byInvite
        }
    }
}

enum AgeRange {
    
    case everyone
    case child
    case teen
    case legal
    case adult
    
    var description: String {
        
        switch self {
        
        case AgeRange.everyone: return "AGE_EVE".localized
        case AgeRange.child:    return "AGE_CHI".localized
        case AgeRange.teen:     return "AGE_TEE".localized
        case AgeRange.legal:    return "AGE_LEG".localized
        case AgeRange.adult:    return "AGE_ADU".localized
        }
    }
    
    static func getAllAgeRanges()-> [String] {
        
        return [AgeRange.everyone.description,
                AgeRange.child.description,
                AgeRange.teen.description,
                AgeRange.legal.description,
                AgeRange.adult.description]
    }
    
    static func getAgeRangeFrom(index: Int)-> AgeRange {
        
        switch index {
            
        case 0:  return AgeRange.everyone
        case 1:  return AgeRange.child
        case 2:  return AgeRange.teen
        case 3:  return AgeRange.legal
        default: return AgeRange.adult
        }
    }
}

struct Event {
    
    var eveImageURL: String
    var eveName: String
    var evePlace: String
    var eveAddress: String
    var eveDate: String
    var eveSchedule: String
    var eveAssitantsType: AssistantType
    var evePrice: String
    var eveDescription: String
    var eveStatus: Bool
    var eveTags: [Tag]
    var evePublications: [Publication]
    var eveComments: [Comment]
    var eveMultimedia: [Multimedia]
    var eveOrganizers: [Organizer]
    var eveSponsorships: [Sponsorship]
    var eveAssistants: [User]
    var eveUserFavorited: [User]
    var eveShared: [User]
    var eveCheckIns: [User]
    var eveFollowers: [User]
    
    static func getNewEvent()-> Event {
        
        return Event(eveImageURL: "",
                     eveName: "",
                     evePlace: "",
                     eveAddress: "",
                     eveDate: "",
                     eveSchedule: "",
                     eveAssitantsType: AssistantType.forAll,
                     evePrice: "",
                     eveDescription: "",
                     eveStatus: true,
                     eveTags:[],
                     evePublications: [],
                     eveComments: [],
                     eveMultimedia: [],
                     eveOrganizers: [],
                     eveSponsorships: [],
                     eveAssistants: [],
                     eveUserFavorited: [],
                     eveShared: [],
                     eveCheckIns: [],
                     eveFollowers: [])
    }
    
    static func getEvents()->[Event]{
        
        return [Event(eveImageURL: "Sicario",
                      eveName: "Sicario 2, Alfombra Roja",
                      evePlace: "Cinemex Antara",
                      eveAddress: "Ejercito Nacional No. 843 - B Col. Granada, 11520 Miguel Hidalgo, CDMX",
                      eveDate: "Lunes 11 de Junio de 2018",
                      eveSchedule: "7 pm - 9pm",
                      eveAssitantsType: AssistantType.byInvite,
                      evePrice: "General $900 | VIP $1,250",
                      eveDescription: "Premier Sicario 2",
                      eveStatus: true,
                      eveTags: [],
                      evePublications: Publication.getPublications(),
                      eveComments: Comment.getcomments(),
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
                      eveAssistants: [User.getUserData()],
                      eveUserFavorited: [User.getUserData()],
                      eveShared: [],
                      eveCheckIns: [],
                      eveFollowers: []),
                Event(eveImageURL: "Increibles",
                      eveName: "Los Increíbles 2 - Premiere México",
                      evePlace: "Cinepolis Universidad",
                      eveAddress: "Av. Universidad 1000, Sta Cruz Atoyac, 03310 Ciudad de México, CDMX",
                      eveDate: "Jueves 14 de Junio de 2018",
                      eveSchedule: "7 pm - 9pm",
                      eveAssitantsType: AssistantType.byInvite,
                      evePrice: "General $900 | VIP $1,250",
                      eveDescription: "Premier Los Increíbles 2",
                      eveStatus: false,
                      eveTags: [],
                      evePublications: Publication.getPublications(),
                      eveComments: [],
                      eveMultimedia: [],
                      eveOrganizers: [Organizer(orgName: "Disney",
                                                orgImageURL: "N/A",
                                                orgLocalImage: UIImage())],
                      eveSponsorships: [Sponsorship(spoName: "Cinemex",
                                                    spoImageURL: "N/A",
                                                    spoLocalImage: UIImage())],
                      eveAssistants: [],
                      eveUserFavorited: [],
                      eveShared: [],
                      eveCheckIns: [],
                      eveFollowers: []),
                Event(eveImageURL: "Tangueros",
                      eveName: "Tangueros",
                      evePlace: "Lunario del Auditorio Nacional",
                      eveAddress: "Paseo de la Reforma 50, Miguel Hidalgo, 11580 Ciudad de México, CDMX",
                      eveDate: "Jueves 12 de Julio de 2018",
                      eveSchedule: "5 pm",
                      eveAssitantsType: AssistantType.byInvite,
                      evePrice: "General $900 | VIP $1,250",
                      eveDescription: "Premier Tangueros",
                      eveStatus: true,
                      eveTags: [],
                      evePublications: Publication.getPublications(),
                      eveComments: [],
                      eveMultimedia: [],
                      eveOrganizers: [Organizer(orgName: "Ocesa",
                                                orgImageURL: "N/A",
                                                orgLocalImage: UIImage())],
                      eveSponsorships: [Sponsorship(spoName: "Citibanamex",
                                                    spoImageURL: "N/A",
                                                    spoLocalImage: UIImage())],
                      eveAssistants: [],
                      eveUserFavorited: [],
                      eveShared: [],
                      eveCheckIns: [],
                      eveFollowers: []),
                Event(eveImageURL: "Miserables",
                      eveName: "Los Miserables",
                      evePlace: "Teatro Telcel",
                      eveAddress: "Miguel de Cervantes Saavedra 386, Ampliación Granada, 11529 Ciudad de México, CDMX",
                      eveDate: "Viernes, Sábado y Domingo",
                      eveSchedule: "Múltiples horarios",
                      eveAssitantsType: AssistantType.byInvite,
                      evePrice: "General $900 | VIP $1,250",
                      eveDescription: "Premier Tangueros",
                      eveStatus: false,
                      eveTags: [],
                      evePublications: Publication.getPublications(),
                      eveComments: [],
                      eveMultimedia: [],
                      eveOrganizers: [Organizer(orgName: "Ocesa",
                                                orgImageURL: "N/A",
                                                orgLocalImage: UIImage())],
                      eveSponsorships: [Sponsorship(spoName: "Citibanamex",
                                                    spoImageURL: "N/A",
                                                    spoLocalImage: UIImage())],
                      eveAssistants: [],
                      eveUserFavorited: [],
                      eveShared: [],
                      eveCheckIns: [],
                      eveFollowers: [])]
    }
}
