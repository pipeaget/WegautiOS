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
import SafariServices

typealias validateOtherInfoAction = (Bool)-> Void

class NewEventOtherInfoVC: UIViewController {

    //MARK: - VARIABLES
    
    var lmUserLocation: CLLocationManager!
    var arrLocationResults: [MKMapItem]!
    var isSearching: Bool = false {
        didSet {
            tvEvent.allowsSelection = isSearching
            tvEvent.reloadData()
        }
    }
    var eventAnnotation = MKPointAnnotation()
    var arrOrganizers: [Organizer]!
    var arrSponsors: [Sponsorship]!
    var arrMultimedia: [Multimedia]!
    var arrTags: [Tag]!
    var canFinishProcess: Bool = false
    var actValidateOtherInfo: validateOtherInfoAction?
    var eventURL: String?
    var eventPlace: String?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var sbEventAddress: UISearchBar!
    @IBOutlet weak var mvEvent: MKMapView!
    @IBOutlet weak var tvEvent: UITableView!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        sbEventAddress.barTintColor = UIColor.deepPurple
        sbEventAddress.tintColor = UIColor.white
        sbEventAddress.placeholder = "NEOI_SB".localized
        sbEventAddress.showsCancelButton = true
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
        arrOrganizers = [Organizer.getNewOrganizer()]
        arrSponsors = [Sponsorship.getNewSponsor()]
        arrMultimedia = [Multimedia.getDefaultMultimedia()]
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
        search.start { [weak self] (response, err) in
        
            guard let places = response else { return }
            self!.arrLocationResults = places.mapItems
            self!.tvEvent.reloadData()
        }
    }
    
    func addPin(aLocation: MKMapItem) {
        
        eventAnnotation.coordinate = aLocation.placemark.coordinate
        eventAnnotation.title = aLocation.name
        mvEvent.addAnnotation(eventAnnotation)
        mvEvent.showAnnotations(mvEvent.annotations, animated: true)
    }
    
    func getHeaderForSection(currentSection: Int)-> UIView{
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        let aView: UIView = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: screenSize.width,
                                                 height: 70))
        aView.backgroundColor = UIColor.white
        
        let lblSectionTitle: UILabel = UILabel(frame: CGRect(x: 20,
                                                             y: 10,
                                                             width: screenSize.width - 40,
                                                             height: 50))
        lblSectionTitle.font = UIFont(name: "Avenir-Book",
                                      size: 20) ?? UIFont.systemFont(ofSize: 20)
        lblSectionTitle.text = getTitleForSection(index: currentSection)
        lblSectionTitle.textColor = UIColor.textColor
        lblSectionTitle.adjustsFontSizeToFitWidth = true
        aView.addSubview(lblSectionTitle)
        
        return aView
    }
    
    func getTitleForSection(index: Int)-> String {
        
        switch index {
            
        case 0:  return "NEOI_ORG".localized
        case 1:  return "NEOI_SPO".localized
        case 2:  return "NEOI_WEB".localized
        case 3:  return "NEOI_MUL".localized
        case 4:  return "NEOI_TAG".localized
        default: return "NEOI_RES".localized
        }
    }
    
    @objc func showURLPreview(aURL: String) {
        
        guard let url = URL(string: "http://" + aURL) else {
            return
        }
        openSafariVC(url: url)
    }
    
    func openSafariVC(url: URL) {
        
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
        safariVC.delegate = self
    }
    
    func validateEventInfo() {
        
        canFinishProcess = (eventPlace != nil && arrTags.count > 0 && eventURL != nil)
        if canFinishProcess {
            if let anAction = self.actValidateOtherInfo {
                anAction(true)
            }
        }
    }
}

//MARK: - EXTENSIONS

extension NewEventOtherInfoVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        getLocalRequestFor(query: searchBar.text! + text)
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        isSearching = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        self.dismissKeyboard()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        self.dismissKeyboard()
    }
}

extension NewEventOtherInfoVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return !isSearching ? 5 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return !isSearching ? getHeaderForSection(currentSection: section) : getHeaderForSection(currentSection: 99)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isSearching ? arrLocationResults.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isSearching {
            
            return 80
        } else {
            
            switch indexPath.section {
                
            case 0:  return 78
            case 1:  return 78
            case 2:  return 70
            case 3:  return 100
            case 4:  return CGFloat(round(Double(Tag.getTags().count / 3)) * 75)
            default: return 0
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !isSearching {
            
            switch indexPath.section {
                
            case 0:
                let aCell: NewOrganizerTVCell = tvEvent.dequeueReusableCell(withIdentifier: "NewOrganizerCell",
                                                                            for: indexPath) as! NewOrganizerTVCell
                return aCell
                
            case 1:
                let aCell: NewSponsorTVCell = tvEvent.dequeueReusableCell(withIdentifier: "NewSponsorCell",
                                                                          for: indexPath) as! NewSponsorTVCell
                return aCell
                
            case 2:
                let aCell: WebEventTVCell = tvEvent.dequeueReusableCell(withIdentifier: "WebURLCell",
                                                                        for: indexPath) as! WebEventTVCell
                aCell.actOpenURL = {
                    (urlToOpen) in
                    self.showURLPreview(aURL: urlToOpen)
                }
                return aCell
                
            case 3:
                let aCell: NewMultimediaTVCell = tvEvent.dequeueReusableCell(withIdentifier: "NewMultimediaCell",
                                                                             for: indexPath) as! NewMultimediaTVCell
                return aCell
                
            default:
                let aCell: NewTagTVCell = tvEvent.dequeueReusableCell(withIdentifier: "NewTagCell",
                                                                      for: indexPath) as! NewTagTVCell
                return aCell
            }
            
        } else {
            
            let aCell: PlaceTVCell = tvEvent.dequeueReusableCell(withIdentifier: "PlaceCell",
                                                                 for: indexPath) as! PlaceTVCell
            aCell.currentPlace = arrLocationResults[indexPath.row]
            return aCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSearching {
            
            addPin(aLocation: arrLocationResults[indexPath.row])
            isSearching = false
            eventPlace = arrLocationResults[indexPath.row].name
            validateEventInfo()
            dismissKeyboard()
        }
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        
        print(error.localizedDescription)
    }
}

extension NewEventOtherInfoVC: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        controller.dismiss(animated: true,
                           completion: nil)
    }
}

extension NewEventOtherInfoVC: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        if isSearching {
            
            dismissKeyboard()
        }
    }
}
