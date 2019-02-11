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
            
        case .party:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGPartyDeselected") : #imageLiteral(resourceName: "TAGPartySelected")
        case .art:           return self.tagIsSelected ? #imageLiteral(resourceName: "LGWhite") : #imageLiteral(resourceName: "LGNavBar")
        case .socialCauses:  return self.tagIsSelected ? #imageLiteral(resourceName: "TAGSocialCausesDeselected") : #imageLiteral(resourceName: "TAGSocialCausesSelected")
        case .comedy:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGTheaterDeselected") : #imageLiteral(resourceName: "TAGTheaterSelected")
        case .theater:       return self.tagIsSelected ? #imageLiteral(resourceName: "LGWhite") : #imageLiteral(resourceName: "LGNavBar")
        case .handicraft:    return self.tagIsSelected ? #imageLiteral(resourceName: "LGWhite") : #imageLiteral(resourceName: "LGNavBar")
        case .education:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGEducationDeselected") : #imageLiteral(resourceName: "TAGEducationSelected")
        case .dance:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGDanceDeselected") : #imageLiteral(resourceName: "TAGDanceSelected")
        case .movies:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGMoviesDeselected") : #imageLiteral(resourceName: "TAGMoviesSelected")
        case .fitness:       return self.tagIsSelected ? #imageLiteral(resourceName: "TAGFItnessDeselected") : #imageLiteral(resourceName: "TAGFitnessSelected")
        case .shopping:      return self.tagIsSelected ? #imageLiteral(resourceName: "TAGShoppingDeselected") : #imageLiteral(resourceName: "TAGShoppingSelected")
        case .sports:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGSportsDeselected") : #imageLiteral(resourceName: "TAGSportsSelected")
        case .lifeStyle:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGLifeStyleDeselected") : #imageLiteral(resourceName: "TAGLifeStyleSelected")
        case .entretainment: return self.tagIsSelected ? #imageLiteral(resourceName: "LGWhite") : #imageLiteral(resourceName: "LGNavBar")
        case .food:          return self.tagIsSelected ? #imageLiteral(resourceName: "TAGFoodDeselected") : #imageLiteral(resourceName: "TAGFoodSelected")
        case .games:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGGamesDeselected") : #imageLiteral(resourceName: "TAGGAmesSelected")
        case .health:        return self.tagIsSelected ? #imageLiteral(resourceName: "TAGHealthDeselected") : #imageLiteral(resourceName: "ICAdd")
        case .gardening:     return self.tagIsSelected ? #imageLiteral(resourceName: "TAGGardeningDeselected") : #imageLiteral(resourceName: "TAGGardeningSelected")
        case .music:         return self.tagIsSelected ? #imageLiteral(resourceName: "TAGMusicDeselected") : #imageLiteral(resourceName: "TAGMusicSelected") 
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
