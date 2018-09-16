//
//  UserNotification.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

enum notificationType {
    
    case event
    case follow
    case badge
}

struct UserNotification {
    
    var notProfImageURL: String
    var notUsername: String
    var notContent: String
    var notCreationDate: String
    var notType: notificationType
    var notEventImageURL: String?
    var notUserProfileId: String?
    var notBadgeImageURL: String?
    
    static func getNotifications()->[UserNotification]{
        
        return [UserNotification(notProfImageURL: "https://pbs.twimg.com/profile_images/725087606522843137/VmtIbx5p_400x400.jpg",
                                 notUsername: "Emma Roberts",
                                 notContent: "Concurso de videojuegos",
                                 notCreationDate: "13/06/18 13:00:00",
                                 notType: notificationType.event,
                                 notEventImageURL: "https://i.ytimg.com/vi/sEv-jSoEjro/hqdefault.jpg",
                                 notUserProfileId: nil,
                                 notBadgeImageURL: nil),
                UserNotification(notProfImageURL: "https://pbs.twimg.com/profile_images/989502275654701058/QwM8zkua_400x400.jpg",
                                notUsername: "Emma Stone",
                                notContent: "Ahora te sigue",
                                notCreationDate: "13/06/18 12:30:00",
                                notType: notificationType.follow,
                                notEventImageURL: nil,
                                notUserProfileId: "007",
                                notBadgeImageURL: nil),
                UserNotification(notProfImageURL: "https://pbs.twimg.com/profile_images/882682164067938305/9DM4hpkj_400x400.jpg",
                                notUsername: "Emma Watson",
                                notContent: "Master Chef Class",
                                notCreationDate: "13/06/18 11:00:00",
                                notType: notificationType.event,
                                notEventImageURL: "http://www.atelierdeschefs.co.uk/blog/wp-content/uploads/2014/02/140113_bpp_225.jpg",
                                notUserProfileId: nil,
                                notBadgeImageURL: nil),
                UserNotification(notProfImageURL: "http://www.arabianbusiness.com/sites/default/files/styles/full_img/public/images/2017/01/17/apple-logo-rainbow.jpg",
                                notUsername: "¡FELICIDADES!",
                                notContent: "Nivel wegaut PRO",
                                notCreationDate: "13/06/18 10:00:00",
                                notType: notificationType.badge,
                                notEventImageURL: nil,
                                notUserProfileId: nil,
                                notBadgeImageURL: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8VDaZ09qWV7VNnjUjRpNQyYT8Ov7xSHqY1ghJyq0WkYR_UbQL")]
    }
}
