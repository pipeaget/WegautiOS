//
//  Publication.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/13/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct Publication {
    
    enum publicationType {
        
        case photo
        case video
        case url
    }
    
    var pubType: publicationType
    var pubImage: UIImage?
    var pubVideo: String?
    var pubUrl: String?
    var pubUser: User
    var pubTitle: String
    var pubDate: Date
    
    static func getPublications() -> [Publication] {
        
        return [Publication(pubType: Publication.publicationType.photo,
                            pubImage: #imageLiteral(resourceName: "Nike"),
                            pubVideo: nil,
                            pubUrl: nil,
                            pubUser: User(usName: "Aget",
                                          usEmail: "pipeor@gmail.com",
                                          usFirstName: "Felipe",
                                          usFathersLastName: "Ortega",
                                          usMothersLastName: "Rodríguez",
                                          usProfileImageURL: "https://scontent.fmex7-2.fna.fbcdn.net/v/t1.0-9/17309773_818248561661688_6777204485022012724_n.jpg?_nc_cat=0&_nc_eui2=AeEFR19ogGgjSeUwcEUSX1tQJZYiWl_DI-_MbcZRivgKTPlpfwhLZgj0QY-6BuXhCSO_NVwWSiRcRSmQ0YndEvZFKNPtPC44dLL5IStdjI2zBw&oh=b13819bf42afd4d61fb15df35003ccf7&oe=5C376DA8",
                                          usDescription: "Pipe",
                                          usWegautLevel: "Begginer"),
                            pubTitle: "¡Increíble!",
                            pubDate: Date()),
                Publication(pubType: Publication.publicationType.photo,
                            pubImage: #imageLiteral(resourceName: "Comedy"),
                            pubVideo: nil,
                            pubUrl: nil,
                            pubUser: User(usName: "Alonso",
                                          usEmail: "pipeor@gmail.com",
                                          usFirstName: "Alonso",
                                          usFathersLastName: "Ortega",
                                          usMothersLastName: "Rodríguez",
                                          usProfileImageURL: "https://scontent.fmex7-2.fna.fbcdn.net/v/t1.0-9/17309773_818248561661688_6777204485022012724_n.jpg?_nc_cat=0&_nc_eui2=AeEFR19ogGgjSeUwcEUSX1tQJZYiWl_DI-_MbcZRivgKTPlpfwhLZgj0QY-6BuXhCSO_NVwWSiRcRSmQ0YndEvZFKNPtPC44dLL5IStdjI2zBw&oh=b13819bf42afd4d61fb15df35003ccf7&oe=5C376DA8",
                                          usDescription: "Pipe",
                                          usWegautLevel: "Begginer"),
                            pubTitle: "¡WOOOOOOW!",
                            pubDate: Date())]
    }
}
