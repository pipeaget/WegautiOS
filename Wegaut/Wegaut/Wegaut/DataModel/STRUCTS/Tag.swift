//
//  Tag.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

enum TagIdentifier {
    
    case party
    case socialCauses
    case theater
    case economy
    case education
    case dance
    case movies
    case fitness
    case shopping
    case sports
    case lifeStyle
    case food
    case videogames
    case cars
    case health
    case gardening
    case music
    
    var tagName: String {
        switch self {
        case .party:         return "TAG_PAR".localized
        case .socialCauses:  return "TAG_SOC".localized
        case .economy:       return "TAG_ECO".localized
        case .theater:       return "TAG_TEA".localized
        case .education:     return "TAG_EDU".localized
        case .dance:         return "TAG_DAN".localized
        case .movies:        return "TAG_MOV".localized
        case .fitness:       return "TAG_FIT".localized
        case .shopping:      return "TAG_SHO".localized
        case .sports:        return "TAG_SPO".localized
        case .lifeStyle:     return "TAG_LIF".localized
        case .food:          return "TAG_FOO".localized
        case .videogames:    return "TAG_GAM".localized
        case .cars:          return "TAG_CAR".localized
        case .health:        return "TAG_HEA".localized
        case .gardening:     return "TAG_GAR".localized
        case .music:         return "TAG_MUS".localized
        }
    }
    
    static func getTagIdentifierFrom(_ tagName: String)-> TagIdentifier {
        switch tagName {
        case "Party":           return TagIdentifier.party
        case "Fiesta":          return TagIdentifier.party
        case "Social Causes":   return TagIdentifier.socialCauses
        case "Causas Sociales": return TagIdentifier.socialCauses
        case "Economy":         return TagIdentifier.economy
        case "Economia":        return TagIdentifier.economy
        case "Theater":         return TagIdentifier.theater
        case "Teatro":          return TagIdentifier.theater
        case "Education":       return TagIdentifier.education
        case "Educación":       return TagIdentifier.education
        case "Dance":           return TagIdentifier.dance
        case "Bailar":          return TagIdentifier.dance
        case "Movies":          return TagIdentifier.movies
        case "Películas":       return TagIdentifier.movies
        case "Fitness":         return TagIdentifier.fitness
        case "Shopping":        return TagIdentifier.shopping
        case "Compras":         return TagIdentifier.shopping
        case "Sports":          return TagIdentifier.sports
        case "Deportes":        return TagIdentifier.sports
        case "Lifestyle":       return TagIdentifier.lifeStyle
        case "Food":            return TagIdentifier.food
        case "Comida":          return TagIdentifier.food
        case "Videogames":      return TagIdentifier.videogames
        case "Videojuegos":     return TagIdentifier.videogames
        case "Cars":            return TagIdentifier.cars
        case "Coches":          return TagIdentifier.cars
        case "Health":          return TagIdentifier.health
        case "Salud":           return TagIdentifier.health
        case "Gardening":       return TagIdentifier.gardening
        case "Jardineria":      return TagIdentifier.gardening
        case "Music":           return TagIdentifier.music
        case "Música":          return TagIdentifier.music
        default:                return TagIdentifier.music
        }
    }
}

enum BadgeType {
    
    case gold
    case silver
    case bronze
}

struct Badge {
    
    var bdType: BadgeType
    var tagId: TagIdentifier
    var bdImage: UIImage {
        
        switch self.tagId {
            
        case .party:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDParty.png")
            case .silver: return #imageLiteral(resourceName: "SMDParty.png")
            case .bronze: return #imageLiteral(resourceName: "BMDParty.png")
            }
            
        case .socialCauses:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDSocialCauses.png")
            case .silver: return #imageLiteral(resourceName: "SMDSocialCauses.png")
            case .bronze: return #imageLiteral(resourceName: "BMDSocialCauses.png")
            }
            
        case .economy:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDEconomy.png")
            case .silver: return #imageLiteral(resourceName: "SMDEconomy.png")
            case .bronze: return #imageLiteral(resourceName: "BMDEconomy.png")
            }
            
        case .theater:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDTheater.png")
            case .silver: return #imageLiteral(resourceName: "SMDTheater.png")
            case .bronze: return #imageLiteral(resourceName: "BMDTheater.png")
            }
            
        case .education:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDEducation.png")
            case .silver: return #imageLiteral(resourceName: "SMDEducation.png")
            case .bronze: return #imageLiteral(resourceName: "BMDEducation.png")
            }
            
        case .dance:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDDance.png")
            case .silver: return #imageLiteral(resourceName: "SMDDance.png")
            case .bronze: return #imageLiteral(resourceName: "BMDDance.png")
            }
            
        case .movies:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDDance.png")
            case .silver: return #imageLiteral(resourceName: "SMDDance.png")
            case .bronze: return #imageLiteral(resourceName: "BMDDance.png")
            }
            
        case .fitness:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDFitness.png")
            case .silver: return #imageLiteral(resourceName: "SMDFitness.png")
            case .bronze: return #imageLiteral(resourceName: "BMDFitness.png")
            }
            
        case .shopping:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDShopping.png")
            case .silver: return #imageLiteral(resourceName: "SMDShopping.png")
            case .bronze: return #imageLiteral(resourceName: "BMDShopping.png")
            }
            
        case .sports:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDSports.png")
            case .silver: return #imageLiteral(resourceName: "SMDSports.png")
            case .bronze: return #imageLiteral(resourceName: "BMDSports.png")
            }
            
        case .lifeStyle:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDLifeStyle.png")
            case .silver: return #imageLiteral(resourceName: "SMDLifeStyle")
            case .bronze: return #imageLiteral(resourceName: "BMDLifeStyle.png")
            }
            
        case .food:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDFood.png")
            case .silver: return #imageLiteral(resourceName: "SMDFood.png")
            case .bronze: return #imageLiteral(resourceName: "BMDFood.png")
            }
            
        case .videogames:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDVideogames.png")
            case .silver: return #imageLiteral(resourceName: "SMDVideogames.png")
            case .bronze: return #imageLiteral(resourceName: "BMDVideogames.png")
            }
            
        case .cars:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDCars.png")
            case .silver: return #imageLiteral(resourceName: "SMDCars.png")
            case .bronze: return #imageLiteral(resourceName: "BMDCars.png")
            }
            
        case .health:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDHealth.png")
            case .silver: return #imageLiteral(resourceName: "SMDHealth.png")
            case .bronze: return #imageLiteral(resourceName: "BMDHealth.png")
            }
            
        case .gardening:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDGardening.png")
            case .silver: return #imageLiteral(resourceName: "SMDGardening.png")
            case .bronze: return #imageLiteral(resourceName: "BMDGardening.png")
            }
            
        case .music:
            switch self.bdType {
            case .gold:   return #imageLiteral(resourceName: "GMDMusic.png")
            case .silver: return #imageLiteral(resourceName: "SMDMusic.png")
            case .bronze: return #imageLiteral(resourceName: "BMDMusic.png")
            }
        }
    }
    
    static func getBadgesAccordingTo(badgeType: BadgeType) -> [Badge] {
        
        return [Badge(bdType: badgeType,
                      tagId: TagIdentifier.party),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.socialCauses),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.economy),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.theater),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.education),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.dance),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.movies),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.fitness),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.shopping),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.sports),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.lifeStyle),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.food),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.videogames),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.cars),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.health),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.gardening),
                Badge(bdType: badgeType,
                      tagId: TagIdentifier.music)]
    }
}

struct Tag {
    
    var tagId: TagIdentifier
    var tagIsSelected: Bool
    var tagStateImage: UIImage {
        switch self.tagId {
        case .party:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGPartyDeselected") : #imageLiteral(resourceName: "TAGPartySelected")
        case .socialCauses:  return self.tagIsSelected ? #imageLiteral(resourceName: "TAGSocialCausesDeselected") : #imageLiteral(resourceName: "TAGSocialCausesSelected")
        case .economy:       return self.tagIsSelected ? #imageLiteral(resourceName: "TAGEconomyDeselected") : #imageLiteral(resourceName: "TAGEconomySelected")
        case .theater:       return self.tagIsSelected ? #imageLiteral(resourceName: "TAGTheaterDeselected") : #imageLiteral(resourceName: "TAGTheaterSelected")
        case .education:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGEducationDeselected") : #imageLiteral(resourceName: "TAGEducationSelected")
        case .dance:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGDanceDeselected") : #imageLiteral(resourceName: "TAGDanceSelected")
        case .movies:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGMoviesDeselected") : #imageLiteral(resourceName: "TAGMoviesSelected")
        case .fitness:       return self.tagIsSelected ? #imageLiteral(resourceName: "TAGFItnessDeselected") : #imageLiteral(resourceName: "TAGFitnessSelected")
        case .shopping:      return self.tagIsSelected ? #imageLiteral(resourceName: "TAGShoppingDeselected") : #imageLiteral(resourceName: "TAGShoppingSelected")
        case .sports:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGSportsDeselected") : #imageLiteral(resourceName: "TAGSportsSelected")
        case .lifeStyle:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGLifeStyleDeselected") : #imageLiteral(resourceName: "TAGLifeStyleSelected")
        case .food:          return self.tagIsSelected ? #imageLiteral(resourceName: "TAGFoodDeselected") : #imageLiteral(resourceName: "TAGFoodSelected")
        case .videogames:    return self.tagIsSelected ? #imageLiteral(resourceName: "TAGVideogamesDeselected") : #imageLiteral(resourceName: "TAGVideogamesSelected")
        case .cars:          return self.tagIsSelected ? #imageLiteral(resourceName: "TAGCarsDeselected") : #imageLiteral(resourceName: "TAGCarsSelected")
        case .health:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGHealthDeselected") : #imageLiteral(resourceName: "ICAdd")
        case .gardening:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGGardeningDeselected") : #imageLiteral(resourceName: "TAGGardeningSelected")
        case .music:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGMusicDeselected") : #imageLiteral(resourceName: "TAGMusicSelected") 
        }
    }
    
    static func convertArrToTags(_ tags: [String])-> [Tag] {
        
        var arrTags: [Tag] = []
        for tag in tags {
            arrTags.append(Tag(tagId: TagIdentifier.getTagIdentifierFrom(tag), tagIsSelected: true))
        }
        return arrTags
    }
    
    static func convertTagsToDic(_ tags: [Tag]) -> [String] {
    
        var arrToReturn: [String] = []
        for tag in tags {
            arrToReturn.append(tag.tagId.tagName)
        }
        return arrToReturn
    }
    
    static func getTags()->[Tag] {
        
        return [Tag(tagId: TagIdentifier.party,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.socialCauses,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.economy,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.theater,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.education,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.dance,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.movies,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.fitness,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.shopping,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.sports,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.lifeStyle,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.food,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.videogames,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.cars,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.health,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.gardening,
                    tagIsSelected: false),
                Tag(tagId: TagIdentifier.music,
                    tagIsSelected: false)]
    }
}
