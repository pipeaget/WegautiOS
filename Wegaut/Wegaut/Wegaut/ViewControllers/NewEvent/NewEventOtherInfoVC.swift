//
//  NewEventOtherInfoVC.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/29/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NewEventOtherInfoVC: UIViewController {

    //MARK: - VARIABLES
    
    var lmUserLocation: CLLocationManager!
    var arrLocationResults: [MKMapItem]!
    var pmEventPlace: MKPlacemark?
    var arrOrganizers: [Organizer]!
    var arrSponsors: [Sponsorship]!
    var arrMultimedia: [Multimedia]!
    var arrTags: [Tag]!
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var sbEventAddress: UISearchBar!
    @IBOutlet weak var mvEvent: MKMapView!
    @IBOutlet weak var tvEvent: UITableView!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sbEventAddress.placeholder = "NEOI_SB".localized
        sbEventAddress.delegate = self
        mvEvent.delegate = self
        lmUserLocation = CLLocationManager()
        lmUserLocation.delegate = self
        lmUserLocation.desiredAccuracy = kCLLocationAccuracyBest
        lmUserLocation.requestWhenInUseAuthorization()
        lmUserLocation.requestLocation()
        if let userLocation = lmUserLocation.location?.coordinate {
            
            centerMapOn(location: userLocation,
                        span: nil)
        }
        arrLocationResults = []
        arrOrganizers = []
        arrSponsors = []
        arrMultimedia = []
        arrTags = []
    }
    
    //MARK: - FUNCTIONS
    
    func centerMapOn(location: CLLocationCoordinate2D, span: MKCoordinateSpan?) {
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location,
                                                            span: span ?? MKCoordinateSpan.init(latitudeDelta: 0.005,
                                                                                                longitudeDelta: 0.005))
        mvEvent.setRegion(region,
                          animated: true)
    }
    
    func getLocalRequestFor(query: String) {
        
        let localRequest: MKLocalSearch.Request = MKLocalSearch.Request()
        localRequest.naturalLanguageQuery = query
        localRequest.region = mvEvent.region
        let search: MKLocalSearch = MKLocalSearch(request: localRequest)
        search.start { (response, err) in
        
            guard let places = response else { return }
            self.arrLocationResults = places.mapItems
            //self.tvAddressResults.reloadData()
        }
    }
    
    func getHeaderForSection(currentSection: Int)-> UIView{
        
        return UIView()
    }
    
    //MARK: - ACTIONS
    
}

//MARK: - EXTENSIONS

extension NewEventOtherInfoVC: UISearchBarDelegate {
    
    
}

extension NewEventOtherInfoVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return tableView == tvEvent ? 5 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return tableView == tvEvent ? getHeaderForSection(currentSection: section) : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return tableView == tvEvent ? 70 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tvEvent {
            
            switch section {
                
            case 0: return arrOrganizers.count
                
            case 1: return arrSponsors.count
                
            case 2: return 1
                
            case 3: return arrMultimedia.count
                
            case 4: return arrTags.count
                
            }
        } else {
            
            return arrLocationResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            //TODO: ORGANIZER CELL
            break
            
        case 1:
            //TODO: SPONSOR CELL
            break
            
        case 2:
            //TODO: EVENTWEB CELL
            break
            
        case 3:
            //TODO: MULTIMEDIA CELL
            break
            
        default:
            //TODO: TAGS CELL
            break
        }
        return UITableViewCell()
    }
}

extension NewEventOtherInfoVC: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        if status == CLAuthorizationStatus.authorizedWhenInUse || status == CLAuthorizationStatus.authorizedAlways {
            
            lmUserLocation.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLocation = locations.last {
            
            centerMapOn(location: currentLocation.coordinate,
                        span: nil)
        }
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        
        print(error.localizedDescription)
    }
    
}
