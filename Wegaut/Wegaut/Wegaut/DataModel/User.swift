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
    var usDescription: String
    var usWegautLevel: String
    
    
    static func getUserData()->User{
        
        return User(usName: "Gabriel_Ramos",
                    usEmail: "pipeor@gmail.com",
                    usFirstName: "Gabriel",
                    usFathersLastName: "Ramos",
                    usMothersLastName: "Peréz",
                    usProfileImageURL: "https://vignette.wikia.nocookie.net/battlefordreamislandfanfiction/images/8/8e/Rainbow_apple_logo_oc.png/revision/latest?cb=20171213183851",
                    usDescription: "Lorem ipsum dolor et amen.",
                    usWegautLevel: "Rookie")
    }
}
