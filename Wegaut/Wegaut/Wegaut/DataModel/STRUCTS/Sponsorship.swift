//
//  Sponsorship.swift
//  wegaut
//
//  Created by Felipe Ortega on 8/11/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

struct Sponsorship {
    
    var spoName: String
    var spoImageURL: String
    var spoLocalImage: UIImage
    
    static func convertSponsorshipToDic(_ sponsorship: Sponsorship)-> [String: Any] {
        
        var dictToReturn: [String: Any] = [:]
        dictToReturn["spoName"] = sponsorship.spoName
        dictToReturn["spoImageURL"] = sponsorship.spoImageURL
        return dictToReturn
    }
    
    static func convertSponsorshipsToDic(_ sponsorships: [Sponsorship])-> [String: Any] {
        
        var arrSponsorships: [[String: Any]] = [[:]]
        for sponsorship in sponsorships {
            arrSponsorships.append(convertSponsorshipToDic(sponsorship))
        }
        return ["sponsorship": arrSponsorships]
    }
    
    static func getAllSponsors()->[Sponsorship]{
        
        return [Sponsorship(spoName: "CitiBanamex",
                            spoImageURL: "http://pluspng.com/img-png/citibanamex-png-acude-directamente-a-una-sucursal-de-las-instituciones-financieras-participantes-y-solicita-tu-credito-mujeres-pyme-580.png", spoLocalImage: UIImage()),
                Sponsorship(spoName: "Microsoft",
                            spoImageURL: "https://cdn.pixabay.com/photo/2013/02/12/09/07/microsoft-80658_640.png", spoLocalImage: UIImage())]
    }
    
    static func getDefaultSponsor()->Sponsorship {
        
        return Sponsorship(spoName: "Wegaut",
                           spoImageURL: "http://wegaut.com",
                           spoLocalImage: #imageLiteral(resourceName: "BGLogo"))
    }
    
    static func getNewSponsor() ->Sponsorship {
        
        return Sponsorship(spoName: "",
                           spoImageURL: "",
                           spoLocalImage: #imageLiteral(resourceName: "ICFollowBack"))
    }
}
