//
//  User.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct User {

    var usId: String
    var usName: String
    var usEmail: String
    var usFirstName: String
    var usLastNames: String
    var usProfileImageURL: String
    var usProfileImage: UIImage
    var usBirthdate: String
    var usPassword: String
    var usDescription: String
    var usWegautLevel: Level
    var usFollowers: [User]
    var usFollowing: [User]
    var usCreatedEvents: [Event]
    var usAssistingEvents: [Event]
    var usFavouriteEvents: [Event]
    var usSharedEvents: [Event]
    var usActivities: [Activity]
    var usTags: [Tag]
    
    static func convertDicToUser(_ aDic: [String: Any])-> User? {
        
        if let anId             = aDic["usId"] as? String,
           let aName            = aDic["usName"] as? String,
           let anEmail          = aDic["usEmail"] as? String,
           let aFirstName       = aDic["usFirstName"] as? String,
           let aLastName        = aDic["usLastNames"] as? String,
           let aProfileImage    = aDic["usProfileImageURL"] as? String,
           let aBirthdate       = aDic["usBirthdate"] as? String,
           let aPassword        = aDic["usPassword"] as? String,
           let aDescription     = aDic["usDescription"] as? String,
           let aWegautLevel     = aDic["usWegautLevel"] as? String {
            
            var aFollowers: [String: Any] = [:]
            if let followers = aDic["usFollowers"] as? [String: Any] {
                aFollowers = followers
            }
            
            var aFollowing: [String: Any] = [:]
            if let following = aDic["usFollowing"] as? [String: Any] {
                aFollowing = following
            }
            
            var aCreatedEvents: [String: Any] = [:]
            if let createdEvents = aDic["usCreatedEvents"] as? [String: Any] {
                aCreatedEvents = createdEvents
            }
            
            var anAssitingEvents: [String: Any] = [:]
            if let assistingEvents = aDic["usAssistingEvents"] as? [String: Any] {
                anAssitingEvents = assistingEvents
            }
            
            var aFavouriteEvents: [String: Any] = [:]
            if let favouriteEvents = aDic["usFavouriteEvents"] as? [String: Any] {
                aFavouriteEvents = favouriteEvents
            }
            
            var aSharedEvents: [String: Any] = [:]
            if let sharedEvents = aDic["usSharedEvents"] as? [String: Any] {
                aSharedEvents = sharedEvents
            }
            
            var anActivities: [String: Any] = [:]
            if let activities = aDic["usActivities"] as? [String: Any] {
                anActivities = activities
            }
            
            var aTags: [String] = []
            if let tags = aDic["usTags"] as? [String] {
                aTags = tags
            }
            return User(usId: anId, usName: aName, usEmail: anEmail, usFirstName: aFirstName, usLastNames: aLastName, usProfileImageURL: aProfileImage, usProfileImage: #imageLiteral(resourceName: "LGNavBar"), usBirthdate: aBirthdate, usPassword: aPassword, usDescription: aDescription, usWegautLevel: Level.getLevelFromString(aWegautLevel), usFollowers: User.convertDicToUsers(aFollowers), usFollowing: User.convertDicToUsers(aFollowing), usCreatedEvents: Event.convertDicToEvents(aCreatedEvents), usAssistingEvents: Event.convertDicToEvents(anAssitingEvents), usFavouriteEvents: Event.convertDicToEvents(aFavouriteEvents), usSharedEvents: Event.convertDicToEvents(aSharedEvents), usActivities: Activity.convertDicToActivities(anActivities), usTags: Tag.convertArrToTags(aTags))
        } else {
            return nil
        }
    }
    
    static func convertDicToUsers(_ aDic: [String: Any]) -> [User] {
        
        var arrUsers: [User] = []
        if let aUsers = aDic["users"] as? [[String: Any]] {
            for user in aUsers {
                if let aUser = User.convertDicToUser(user) {
                    arrUsers.append(aUser)
                }
            }
            return arrUsers
        }
        return arrUsers
    }
    
    static func convertUserToDic(_ user:User)-> [String:Any] {
        
        var dicToReturn: [String: Any] = [:]
        dicToReturn["usId"]              = user.usId
        dicToReturn["usName"]            = user.usName
        dicToReturn["usEmail"]           = user.usEmail
        dicToReturn["usFirstName"]       = user.usFirstName
        dicToReturn["usLastNames"]       = user.usLastNames
        dicToReturn["usProfileImageURL"] = user.usProfileImageURL
        dicToReturn["usBirthdate"]       = user.usBirthdate
        dicToReturn["usPassword"]        = user.usPassword
        dicToReturn["usDescription"]     = user.usDescription
        dicToReturn["usWegautLevel"]     = user.usWegautLevel.description
        dicToReturn["usFollowers"]       = convertUsersToDic(user.usFollowers)
        dicToReturn["usFollowing"]       = convertUsersToDic(user.usFollowing)
        dicToReturn["usCreatedEvents"]   = user.usCreatedEvents
        dicToReturn["usAssistingEvents"] = user.usAssistingEvents
        dicToReturn["usFavouriteEvents"] = user.usFavouriteEvents
        dicToReturn["usSharedEvents"]    = user.usSharedEvents
        dicToReturn["usActivities"]      = user.usActivities
        dicToReturn["usTags"]            = user.usTags
        return dicToReturn
    }
    
    static func convertUsersToDic(_ users: [User]) -> [String: Any] {
        
        var arrDicUsers: [[String: Any]] = [[:]]
        for user in users {
            arrDicUsers.append(convertUserToDic(user))
        }
        return ["users" : arrDicUsers]
    }
    
    static func getUserData()-> User{
        
      return User(usId: "",
                  usName: "Emma Roberts",
                    usEmail: "example@example.com",
                    usFirstName: "Emma",
                    usLastNames: "Roberts",
                    usProfileImageURL: "https://m.media-amazon.com/images/M/MV5BMTQ4Njg2NTA4MF5BMl5BanBnXkFtZTgwNjAxNjQ0MDI@._V1_.jpg",
                    usProfileImage: #imageLiteral(resourceName: "ICAddImage.png"),
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
                    usTags: [])
    }

  static func newUser() -> User {
    return User(usId: "", usName: "",
                usEmail: "",
                usFirstName: "",
                usLastNames: "",
                usProfileImageURL: "",
                usProfileImage: #imageLiteral(resourceName: "ICFollowBack"),
                usBirthdate: "",
                usPassword: "",
                usDescription: "REG_DESC".localized,
                usWegautLevel: Level.noob,
                usFollowers: [],
                usFollowing: [],
                usCreatedEvents: [],
                usAssistingEvents: [],
                usFavouriteEvents: [],
                usSharedEvents: [],
                usActivities: [],
                usTags: [])
  }
    
    static func isUserInArray(anArray: [User])-> Bool {
        
        return anArray.contains(where: {$0.usEmail == User.getUserData().usEmail})
    }
    
    static func getFollowers()-> [User] {
        
      return [User(usId: "", usName: "Jessy Jacke",
                     usEmail: "example@example.com",
                     usFirstName: "Jessy",
                     usLastNames: "Jacke",
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
              User(usId: "", usName: "Erick Smith",
                     usEmail: "example@example.com",
                     usFirstName: "Erick",
                     usLastNames: "Smith",
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
              User(usId: "", usName: "Lucia Don",
                     usEmail: "example@example.com",
                     usFirstName: "Lucia",
                     usLastNames: "Don",
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
              User(usId: "", usName: "Soona Ten",
                     usEmail: "example@example.com",
                     usFirstName: "Soona",
                     usLastNames: "Ten",
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
              User(usId: "", usName: "Elizabeth Watson",
                     usEmail: "example@example.com",
                     usFirstName: "Elizabeth",
                     usLastNames: "Watson",
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
                     usTags: [])]
    }
    
    static func getFollowing()-> [User] {
        
      return [User(usId: "", usName: "Elizabeth Watson",
                     usEmail: "example@example.com",
                     usFirstName: "Elizabeth",
                     usLastNames: "Watson",
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
              User(usId: "", usName: "Jessy Jacke",
                     usEmail: "example@example.com",
                     usFirstName: "Jessy",
                     usLastNames: "Jacke",
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
              User(usId: "", usName: "Erick Smith",
                     usEmail: "example@example.com",
                     usFirstName: "Erick",
                     usLastNames: "Smith",
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
                User(usId: "", usName: "Lucia Don",
                     usEmail: "example@example.com",
                     usFirstName: "Lucia",
                     usLastNames: "Don",
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
                User(usId: "", usName: "Soona Ten",
                     usEmail: "example@example.com",
                     usFirstName: "Soona",
                     usLastNames: "Ten",
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
                     usTags: [])]
    }
    
    static func getUserCompleteName(user: User)-> String {
        
        return user.usFirstName + " " + user.usLastNames
    }
}
