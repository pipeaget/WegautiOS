//
//  Tag.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct Tag {
    
    enum TagIdentifier {
        
        case party
        case art
        case socialCauses
        case comedy
        case theater
        case handicraft
        case education
        case dance
        case movies
        case fitness
        case shopping
        case sports
        case lifeStyle
        case entretainment
        case food
        case games
        case health
        case gardening
        case music
    }
    
    var tagId: TagIdentifier
    var tagIsSelected: Bool
    var tagName: String {
        
        switch self.tagId {
            
        case .party:         return "TAG_PAR".localized
        case .art:           return "TAG_ART".localized
        case .socialCauses:  return "TAG_SOC".localized
        case .comedy:        return "TAG_COM".localized
        case .theater:       return "TAG_TEA".localized
        case .handicraft:    return "TAG_HAN".localized
        case .education:     return "TAG_EDU".localized
        case .dance:         return "TAG_DAN".localized
        case .movies:        return "TAG_MOV".localized
        case .fitness:       return "TAG_FIT".localized
        case .shopping:      return "TAG_SHO".localized
        case .sports:        return "TAG_SPO".localized
        case .lifeStyle:     return "TAG_LIF".localized
        case .entretainment: return "TAG_ENT".localized
        case .food:          return "TAG_FOO".localized
        case .games:         return "TAG_GAM".localized
        case .health:        return "TAG_HEA".localized
        case .gardening:     return "TAG_GAR".localized
        case .music:         return "TAG_MUS".localized
        }
    }
    
    var tagStateImage: UIImage {
        
        switch self.tagId {
            
        case .party:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGPartySelected") : #imageLiteral(resourceName: "TAGPartyDeselected")
        case .art:           return self.tagIsSelected ? #imageLiteral(resourceName: "LGNavBar") : #imageLiteral(resourceName: "LGWhite")
        case .socialCauses:  return self.tagIsSelected ? #imageLiteral(resourceName: "TAGSocialCausesSelected") : #imageLiteral(resourceName: "TAGSocialCausesDeselected")
        case .comedy:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGTheaterSelected") : #imageLiteral(resourceName: "TAGTheaterDeselected")
        case .theater:       return self.tagIsSelected ? #imageLiteral(resourceName: "LGNavBar") : #imageLiteral(resourceName: "LGWhite")
        case .handicraft:    return self.tagIsSelected ? #imageLiteral(resourceName: "LGNavBar") : #imageLiteral(resourceName: "LGWhite")
        case .education:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGEducationSelected") : #imageLiteral(resourceName: "TAGEducationDeselected")
        case .dance:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGDanceSelected") : #imageLiteral(resourceName: "TAGDanceDeselected")
        case .movies:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGMoviesSelected") : #imageLiteral(resourceName: "TAGMoviesDeselected")
        case .fitness:       return self.tagIsSelected ? #imageLiteral(resourceName: "TAGFitnessSelected") : #imageLiteral(resourceName: "TAGFItnessDeselected")
        case .shopping:      return self.tagIsSelected ? #imageLiteral(resourceName: "TAGShoppingSelected") : #imageLiteral(resourceName: "TAGShoppingDeselected")
        case .sports:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGSportsSelected") : #imageLiteral(resourceName: "TAGSportsDeselected")
        case .lifeStyle:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGLifeStyleSelected") : #imageLiteral(resourceName: "TAGLifeStyleDeselected")
        case .entretainment: return self.tagIsSelected ? #imageLiteral(resourceName: "LGNavBar") : #imageLiteral(resourceName: "LGWhite")
        case .food:          return self.tagIsSelected ? #imageLiteral(resourceName: "TAGFoodSelected") : #imageLiteral(resourceName: "TAGFoodDeselected")
        case .games:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGGAmesSelected") : #imageLiteral(resourceName: "TAGGamesDeselected")
        case .health:        return self.tagIsSelected ? #imageLiteral(resourceName: "ICAdd") : #imageLiteral(resourceName: "TAGHealthDeselected")
        case .gardening:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGGardeningSelected") : #imageLiteral(resourceName: "TAGGardeningDeselected")
        case .music:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGMusicSelected") : #imageLiteral(resourceName: "TAGMusicDeselected")
        }
    }
    
    static func getTags()->[Tag] {
        
        return [Tag(tagId: Tag.TagIdentifier.party,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.art,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.socialCauses,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.comedy,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.theater,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.handicraft,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.education,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.dance,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.movies,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.fitness,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.shopping,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.sports,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.lifeStyle,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.entretainment,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.food,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.games,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.health,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.gardening,
                    tagIsSelected: false),
                Tag(tagId: Tag.TagIdentifier.music,
                    tagIsSelected: false)]
    }
}
