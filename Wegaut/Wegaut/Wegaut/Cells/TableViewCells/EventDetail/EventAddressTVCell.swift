//
//  EventAddressTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/17/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import MapKit

typealias actHowToGetThere = ()->Void

class EventAddressTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentEvent: Event?{
        didSet{
            drawCell()
        }
    }
    var howToGetThereAction: actHowToGetThere?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblAboutPlace: UILabel!
    @IBOutlet weak var mvwEventPlace: MKMapView!
    @IBOutlet weak var lblEventPlace: UILabel!
    @IBOutlet weak var lblEventAddress: UILabel!
    @IBOutlet weak var btnHowToGetThere: UIButton!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        vwContainer.layer.borderColor = UIColor.lightGray.cgColor
        vwContainer.layer.borderWidth = 0.5
        vwContainer.layer.masksToBounds = true
        vwContainer.cornerRadius(cornerRadius: 1)
        mvwEventPlace.cornerRadius(cornerRadius: 5)
        btnHowToGetThere.cornerRadius(cornerRadius: 10)
        lblAboutPlace.text = "EAC_TIT".localized
        btnHowToGetThere.setTitle("EAC_HTGT".localized,
                                  for: UIControlState.normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        guard let anEvent = currentEvent else{
            
            return
        }
        configure(location: anEvent.eveAddress, anAnnotationTitle: anEvent.evePlace)
        lblEventPlace.attributedText = anEvent.evePlace.getStringWith(anImage: #imageLiteral(resourceName: "ICPin"))
        lblEventAddress.text = anEvent.eveAddress
    }
    
    func configure(location: String, anAnnotationTitle:String){
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location) { (placemarks, error) in
            
            if let error = error{
                print(error)
                return
            }
            
            if let placemarks = placemarks{
                
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location{
                    annotation.coordinate = location.coordinate
                    annotation.title = anAnnotationTitle
                    self.mvwEventPlace.addAnnotation(annotation)
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate,
                                                                    1000,
                                                                    1000)
                    self.mvwEventPlace.setRegion(region,
                                                 animated: true)
                }
            }
        }
    }
    
    //MARK: - ACTIONS

    @IBAction func actHowToGetThere(_ sender: UIButton) {
        
        if let anAction = howToGetThereAction{
            anAction()
        }
    }
}
