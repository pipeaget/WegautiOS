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
