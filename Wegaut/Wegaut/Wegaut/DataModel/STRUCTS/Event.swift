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
    
    static func getAssistantTypeFromDescription(_ string: String)-> AssistantType {
        
        switch string {
        case "Todos": return AssistantType.forAll
        case "All": return AssistantType.forAll
        case "Público": return AssistantType.forPublic
        case "Public": return AssistantType.forPublic
        case "Tickets en venta": return AssistantType.byTicket
        case "Selling Tickets": return AssistantType.byTicket
        case "Solo por invitación": return AssistantType.byInvite
        case "Only by Invite": return AssistantType.byInvite
        default: return AssistantType.byTicket
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
    var eveUsersShared: [User]
    var eveUsersCheckIns: [User]
    var eveUsersFollowers: [User]
    
    static func convertDicToEvent(_ aDic: [String: Any])-> Event? {
        
        if let anImageURL = aDic["eveImageURL"] as? String,
           let aName = aDic["eveName"] as? String,
            let aPlace = aDic["evePlace"] as? String,
            let anAddress = aDic["eveAddress"] as? String,
            let aDate = aDic["eveDate"] as? String,
            let aSchedule = aDic["eveSchedule"] as? String,
            let anAssistantsType = aDic["eveAssitantsType"] as? String,
            let aPrice = aDic["evePrice"] as? String,
            let aDescription = aDic["eveDescription"] as? String,
            let aStatus = aDic["eveStatus"] as? String,
            let aTags = aDic["eveTags"] as? [String],
            let aPublications = aDic["evePublications"] as? [String: Any],
            let aComments = aDic["eveComments"] as? [String: Any],
            let aMultimedias = aDic["eveMultimedia"] as? [String: Any],
            let anOrganizers = aDic["eveOrganizers"] as? [String: Any],
            let aSponsorships = aDic["eveSponsorships"] as? [String: Any],
            let anAssitants = aDic["eveAssistants"] as? [String: Any],
            let aFavourited = aDic["eveUserFavorited"] as? [String: Any],
            let aShared = aDic["eveShared"] as? [String: Any],
            let aCheckIns = aDic["eveCheckIns"] as? [String: Any],
            let aFollowers = aDic["eveFollowers"] as? [String: Any] {
            
            return Event(eveImageURL: anImageURL, eveName: aName, evePlace: aPlace, eveAddress: anAddress, eveDate: aDate, eveSchedule: aSchedule, eveAssitantsType: AssistantType.getAssistantTypeFromDescription(anAssistantsType), evePrice: aPrice, eveDescription: aDescription, eveStatus: aStatus.getBoolFromString(), eveTags: Tag.convertArrToTags(aTags), evePublications: Publication.convertDicToPublications(aPublications), eveComments: Comment.convertDicToComments(aComments), eveMultimedia: Multimedia.convertDicToMultimedias(aMultimedias), eveOrganizers: Organizer.convertDicToOrganizers(anOrganizers), eveSponsorships: Sponsorship.convertDicToSponsorships(aSponsorships), eveAssistants: User.convertDicToUsers(anAssitants), eveUserFavorited: User.convertDicToUsers(aFavourited), eveUsersShared: User.convertDicToUsers(aShared), eveUsersCheckIns: User.convertDicToUsers(aCheckIns), eveUsersFollowers: User.convertDicToUsers(aFollowers))
            
        } else  {
            return nil
        }
    }
    
    static func convertDicToEvents(_ aDic: [String: Any]) -> [Event] {
        
        var arrEvents: [Event] = []
        if let anEvents = aDic["events"] as? [[String: Any]] {
            for event in anEvents {
                if let anEvent = Event.convertDicToEvent(event) {
                    arrEvents.append(anEvent)
                }
            }
            return arrEvents
        }
        return arrEvents
    }
    
    static func convertEventToDic(_ event: Event) -> [String: Any] {
        
        var dictToReturn: [String: Any] = [:]
        dictToReturn["eveImageURL"]      = event.eveImageURL
        dictToReturn["eveName"]          = event.eveName
        dictToReturn["evePlace"]         = event.evePlace
        dictToReturn["eveAddress"]       = event.eveAddress
        dictToReturn["eveDate"]          = event.eveDate
        dictToReturn["eveSchedule"]      = event.eveSchedule
        dictToReturn["eveAssitantsType"] = event.eveAssitantsType
        dictToReturn["evePrice"]         = event.evePrice
        dictToReturn["eveDescription"]   = event.eveDescription
        dictToReturn["eveStatus"]        = event.eveStatus
        dictToReturn["eveTags"]          = Tag.convertTagsToDic(event.eveTags)
        dictToReturn["evePublications"]  = Publication.convertPublicationsToDic(event.evePublications)
        dictToReturn["eveComments"]      = Comment.convertCommentsToDic(event.eveComments)
        dictToReturn["eveMultimedia"]    = Multimedia.convertMultimediasToDic(event.eveMultimedia)
        dictToReturn["eveOrganizers"]    = Organizer.convertOrganizersToDic(event.eveOrganizers)
        dictToReturn["eveSponsorships"]  = Sponsorship.convertSponsorshipsToDic(event.eveSponsorships)
        dictToReturn["eveAssistants"]    = User.convertUsersToDic(event.eveAssistants)
        dictToReturn["eveUserFavorited"] = User.convertUsersToDic(event.eveUserFavorited)
        dictToReturn["eveShared"]        = User.convertUsersToDic(event.eveUsersShared)
        dictToReturn["eveCheckIns"]      = User.convertUsersToDic(event.eveUsersCheckIns)
        dictToReturn["eveFollowers"]     = User.convertUsersToDic(event.eveUsersFollowers)
        return dictToReturn
    }
    
    static func convertEventsToDic(_ events: [Event])-> [String: Any] {
        
        var arrEvents: [[String: Any]] = [[:]]
        for event in events {
            arrEvents.append(convertEventToDic(event))
        }
        return ["events": arrEvents]
    }
    
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
                     eveUsersShared: [],
                     eveUsersCheckIns: [],
                     eveUsersFollowers: [])
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
                    eveComments: Comment.getComments(),
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
                    eveUsersShared: [],
                    eveUsersCheckIns: [],
                    eveUsersFollowers: []),
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
                    eveComments: Comment.getComments(),
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
                    eveUsersShared: [],
                    eveUsersCheckIns: [],
                    eveUsersFollowers: []),
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
                    eveComments: Comment.getComments(),
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
                    eveUsersShared: [],
                    eveUsersCheckIns: [],
                    eveUsersFollowers: []),
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
                    eveComments: Comment.getComments(),
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
                    eveUsersShared: [],
                    eveUsersCheckIns: [],
                    eveUsersFollowers: []),
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
                    eveComments: Comment.getComments(),
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
                    eveUsersShared: [],
                    eveUsersCheckIns: [],
                    eveUsersFollowers: []),
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
                      eveComments: Comment.getComments(),
                      eveMultimedia: [],
                      eveOrganizers: [Organizer(orgName: "Ergaut",
                                                orgImageURL: "N/A",
                                                orgLocalImage: UIImage())],
                      eveSponsorships: [Sponsorship(spoName: "TBC",
                                                    spoImageURL: "N/A",
                                                    spoLocalImage: UIImage())],
                      eveAssistants: [User.getUserData()],
                      eveUserFavorited: [User.getUserData()],
                      eveUsersShared: [],
                      eveUsersCheckIns: [],
                      eveUsersFollowers: []),
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
                      eveUsersShared: [],
                      eveUsersCheckIns: [],
                      eveUsersFollowers: []),
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
                      eveUsersShared: [],
                      eveUsersCheckIns: [],
                      eveUsersFollowers: []),
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
                      eveUsersShared: [],
                      eveUsersCheckIns: [],
                      eveUsersFollowers: [])]
    }
}
