//
//  User.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct User {
    
    var usName: String
    var usEmail: String
    var usFirstName: String
    var usFathersLastName: String
    var usMothersLastName: String
    var usProfileImageURL: String
    var usBirthdate: Date
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
        
        return User(usName: "Emma Roberts",
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
                    usTags: [])
    }
    
    static func isUserInArray(anArray: [User])-> Bool {
        
        return anArray.contains(where: {$0.usEmail == User.getUserData().usEmail})
    }
    
    static func getFollowers()-> [User] {
        
        return [User(usName: "Jessy Jacke",
                     usEmail: "example@example.com",
                     usFirstName: "Jessy",
                     usFathersLastName: "Jacke",
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
                User(usName: "Erick Smith",
                     usEmail: "example@example.com",
                     usFirstName: "Erick",
                     usFathersLastName: "Smith",
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
                User(usName: "Lucia Don",
                     usEmail: "example@example.com",
                     usFirstName: "Lucia",
                     usFathersLastName: "Don",
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
                User(usName: "Soona Ten",
                     usEmail: "example@example.com",
                     usFirstName: "Soona",
                     usFathersLastName: "Ten",
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
                User(usName: "Elizabeth Watson",
                     usEmail: "example@example.com",
                     usFirstName: "Elizabeth",
                     usFathersLastName: "Watson",
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
                     usTags: [])]
    }
    
    static func getFollowing()-> [User] {
        
        return [User(usName: "Elizabeth Watson",
                     usEmail: "example@example.com",
                     usFirstName: "Elizabeth",
                     usFathersLastName: "Watson",
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
                User(usName: "Jessy Jacke",
                     usEmail: "example@example.com",
                     usFirstName: "Jessy",
                     usFathersLastName: "Jacke",
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
                User(usName: "Erick Smith",
                     usEmail: "example@example.com",
                     usFirstName: "Erick",
                     usFathersLastName: "Smith",
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
                User(usName: "Lucia Don",
                     usEmail: "example@example.com",
                     usFirstName: "Lucia",
                     usFathersLastName: "Don",
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
                User(usName: "Soona Ten",
                     usEmail: "example@example.com",
                     usFirstName: "Soona",
                     usFathersLastName: "Ten",
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
                     usTags: [])]
    }
    
    static func getUserCompleteName(user: User)-> String {
        
        return user.usFirstName + " " + user.usFathersLastName + " " + user.usMothersLastName
    }
}
