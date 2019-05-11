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
        
      return [Event(eveImageURL: "Corona",
                    eveName: "Corona Capital 2019 ",
                    evePlace: "Autódromo Hermanos Rodríguez, Ciudad de México, México",
                    eveAddress: "Granjas México, 08400 Ciudad de México, CDMX",
                    eveDate: "17 de noviembre de 2018 – 19 de noviembre de 2018",
                    eveSchedule: "2 pm - 12 am",
                    eveAssitantsType: AssistantType.byTicket,
                    evePrice: "General $900 | VIP $1,250",
                    eveDescription: "Corona Capital 2019",
                    eveStatus: true,
                    eveTags: [],
                    evePublications: Publication.getPublications(),
                    eveComments: Comment.getcomments(),
                    eveMultimedia: [],
                    eveOrganizers: [Organizer(orgName: "Corona",
                                              orgImageURL: "N/A",
                                              orgLocalImage: UIImage())],
                    eveSponsorships: [Sponsorship(spoName: "Vans",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage()),
                                      Sponsorship(spoName: "Samsung",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage())],
                    eveAssistants: [User.getUserData()],
                    eveUserFavorited: [User.getUserData()],
                    eveShared: [],
                    eveCheckIns: [],
                    eveFollowers: []),
              Event(eveImageURL: "Ceremonia",
                    eveName: "Festival Ceremonia GNP 2019",
                    evePlace: "Centro Dinamico Pegaso, Toluca, MEX",
                    eveAddress: "Av. Universidad 1000, Sta Cruz Atoyac, 03310 Ciudad de México, CDMX",
                    eveDate: "Sábado 6 de abril de 2019",
                    eveSchedule: "1 pm",
                    eveAssitantsType: AssistantType.forPublic,
                    evePrice: "General $900 | VIP $1,250",
                    eveDescription: "Ceremonia GNP 2019",
                    eveStatus: true,
                    eveTags: [],
                    evePublications: Publication.getPublications(),
                    eveComments: Comment.getcomments(),
                    eveMultimedia: [],
                    eveOrganizers: [Organizer(orgName: "GNP",
                                              orgImageURL: "N/A",
                                              orgLocalImage: UIImage())],
                    eveSponsorships: [Sponsorship(spoName: "Aeroméxico",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage()),
                                      Sponsorship(spoName: "Pepsi",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage())],
                    eveAssistants: [User.getUserData()],
                    eveUserFavorited: [User.getUserData()],
                    eveShared: [],
                    eveCheckIns: [],
                    eveFollowers: []),
              Event(eveImageURL: "Vive",
                    eveName: "Vive Latino",
                    evePlace: "Foro Sol, Ciudad de México, México",
                    eveAddress: "Av. Viaducto Rio de la Piedad S/N, Granjas México, 08400 Iztacalco, CDMX",
                    eveDate: "Sábado 16 de MArzo de 2019",
                    eveSchedule: "2 pm - 12 am",
                    eveAssitantsType: AssistantType.forPublic,
                    evePrice: "General $900 | VIP $1,250",
                    eveDescription: "Vive LAtino 2019",
                    eveStatus: true,
                    eveTags: [],
                    evePublications: Publication.getPublications(),
                    eveComments: Comment.getcomments(),
                    eveMultimedia: [],
                    eveOrganizers: [Organizer(orgName: "INDIO",
                                              orgImageURL: "N/A",
                                              orgLocalImage: UIImage())],
                    eveSponsorships: [Sponsorship(spoName: "Pepsi",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage()),
                                      Sponsorship(spoName: "Doritos",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage())],
                    eveAssistants: [User.getUserData()],
                    eveUserFavorited: [User.getUserData()],
                    eveShared: [],
                    eveCheckIns: [],
                    eveFollowers: []),
              Event(eveImageURL: "Tenis",
                    eveName: "Abierto Mexicano de Tennis Telcel",
                    evePlace: "Teatro Telcel",
                    eveAddress: "Miguel de Cervantes Saavedra 386, Ampliación Granada, 11529 Ciudad de México, CDMX",
                    eveDate: "25 de Febrero a 2 de Marzo de 2019",
                    eveSchedule: "8 am - 12 am",
                    eveAssitantsType: AssistantType.byInvite,
                    evePrice: "General $900 | VIP $1,250",
                    eveDescription: "Abierto Mexicano de Tennis Telcel",
                    eveStatus: true,
                    eveTags: [],
                    evePublications: Publication.getPublications(),
                    eveComments: Comment.getcomments(),
                    eveMultimedia: [],
                    eveOrganizers: [Organizer(orgName: "ATP",
                                              orgImageURL: "N/A",
                                              orgLocalImage: UIImage())],
                    eveSponsorships: [Sponsorship(spoName: "HSBC",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage()),
                                      Sponsorship(spoName: "Telcel",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage())],
                    eveAssistants: [User.getUserData()],
                    eveUserFavorited: [User.getUserData()],
                    eveShared: [],
                    eveCheckIns: [],
                    eveFollowers: []),
              Event(eveImageURL: "Boda",
                    eveName: "La boda de mi mejor amigo",
                    evePlace: "Cinemex Antara",
                    eveAddress: "Ejercito Nacional No. 843 - B Col. Granada, 11520 Miguel Hidalgo, CDMX",
                    eveDate: "07 de Febrero de 2019",
                    eveSchedule: "8:30 pm",
                    eveAssitantsType: AssistantType.byInvite,
                    evePrice: "General $900 | VIP $1,250",
                    eveDescription: "Premier la boda de mi mejor amigo",
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
                                      Sponsorship(spoName: "Antara Fashion Hall",
                                                  spoImageURL: "N/A",
                                                  spoLocalImage: UIImage())],
                    eveAssistants: [User.getUserData()],
                    eveUserFavorited: [User.getUserData()],
                    eveShared: [],
                    eveCheckIns: [],
                    eveFollowers: []),
              Event(eveImageURL: "Wegaut",
                      eveName: "Wegaut Launch",
                      evePlace: "Joy Room Antara",
                      eveAddress: "Ejercito Nacional No. 843 - B Col. Granada, 11520 Miguel Hidalgo, CDMX",
                      eveDate: "Viernes 19 de Abril de 2019",
                      eveSchedule: "8:30 pm",
                      eveAssitantsType: AssistantType.byInvite,
                      evePrice: "Por invitación",
                      eveDescription: "Wegaut Launch",
                      eveStatus: true,
                      eveTags: [],
                      evePublications: Publication.getPublications(),
                      eveComments: Comment.getcomments(),
                      eveMultimedia: [],
                      eveOrganizers: [Organizer(orgName: "Ergaut",
                                                orgImageURL: "N/A",
                                                orgLocalImage: UIImage())],
                      eveSponsorships: [Sponsorship(spoName: "TBC",
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
