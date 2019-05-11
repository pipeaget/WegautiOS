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
    
    static func convertCommentToDic(_ comment: Comment)-> [String: Any] {
        
        var dicToReturn: [String: Any] = [:]
        dicToReturn["comUser"] = User.convertUserToDic(comment.comUser)
        dicToReturn["comText"] = comment.comText
        dicToReturn["comDate"] = comment.comDate
        return dicToReturn
    }
    
    static func convertCommentsToDic(_ comments: [Comment])-> [String: Any] {
        
        var arrComments: [[String: Any]] = [[:]]
        for comment in comments {
            arrComments.append(convertCommentToDic(comment))
        }
        return ["comments": arrComments]
    }
    
    static func getComments()-> [Comment]{
        
      return [Comment(comUser: User(usId: "", usName: "Emma Roberts",
                                      usEmail: "example@example.com",
                                      usFirstName: "Emma",
                                      usLastNames: "Roberts",
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
                        comText: "I'm so excited about this event!",
                        comDate: "18/06/18"),
              Comment(comUser: User(usId: "", usName: "Emma Roberts",
                    usEmail: "example@example.com",
                    usFirstName: "Emma",
                    usLastNames: "Roberts",
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
                        comText: "Can't wait to be there!",
                        comDate: "17/06/18"),
              Comment(comUser: User(usId: "", usName: "Emma Roberts",
                                  usEmail: "example@example.com",
                                  usFirstName: "Emma",
                                  usLastNames: "Roberts",
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
                        comText: "Awesome!",
                        comDate: "17/06/18")]
    }
}
