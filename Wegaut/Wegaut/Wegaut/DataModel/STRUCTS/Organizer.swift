//
//  Organizer.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/17/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct Organizer {
    
    var orgName: String
    var orgImageURL: String
    var orgLocalImage: UIImage
    
    static func getAllOrganizers()->[Organizer]{
        
        return [Organizer(orgName: "CitiBanamex",
                          orgImageURL: "http://pluspng.com/img-png/citibanamex-png-acude-directamente-a-una-sucursal-de-las-instituciones-financieras-participantes-y-solicita-tu-credito-mujeres-pyme-580.png", orgLocalImage: UIImage()),
                Organizer(orgName: "Microsoft",
                          orgImageURL: "https://cdn.pixabay.com/photo/2013/02/12/09/07/microsoft-80658_640.png", orgLocalImage: UIImage())]
    }
    
    static func getDefaultOrganizer()->Organizer {
        
        return Organizer(orgName: "Wegaut",
                         orgImageURL: "http://wegaut.com",
                         orgLocalImage: #imageLiteral(resourceName: "BGLogo"))
    }
}
