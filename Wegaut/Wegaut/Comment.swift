//
//  Comment.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/18/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct Comment {
    
    var comUser: User
    var comText: String
    var comDate: String
    
    static func getcomments()->[Comment]{
        
        return [Comment(comUser: User(usName: "Emma Roberts",
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
                        comText: "I'm so excited about this event!",
                        comDate: "18/06/18"),
                Comment(comUser: User(usName: "Emma Roberts",
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
                        comText: "Can't wait to be there!",
                        comDate: "17/06/18"),
            Comment(comUser: User(usName: "Emma Roberts",
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
                        comText: "Awesome!",
                        comDate: "17/06/18")]
    }
}
