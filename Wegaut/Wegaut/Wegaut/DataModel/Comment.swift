//
//  Comment.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/18/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct Comment {
    
    var comUser: String
    var comUserImageURL: String
    var comText: String
    var comDate: String
    
    static func getcomments()->[Comment]{
        
        return [Comment(comUser: "Emma Stone",
                        comUserImageURL: "https://pbs.twimg.com/profile_images/989502275654701058/QwM8zkua_400x400.jpg",
                        comText: "I'm so excited about this event!",
                        comDate: "18/06/18"),
                Comment(comUser: "Emma Roberts",
                        comUserImageURL: "https://pbs.twimg.com/profile_images/725087606522843137/VmtIbx5p_400x400.jpg",
                        comText: "Can't wait to be there!",
                        comDate: "17/06/18"),
                Comment(comUser: "Emma Watson",
                        comUserImageURL: "https://pbs.twimg.com/profile_images/882682164067938305/9DM4hpkj_400x400.jpg",
                        comText: "Awesome!",
                        comDate: "17/06/18")]
    }
}
