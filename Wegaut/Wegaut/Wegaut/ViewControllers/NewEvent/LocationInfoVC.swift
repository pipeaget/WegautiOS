//
//  LocationInfoVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 7/23/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationInfoVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var lmUserLocation: CLLocationManager!
    var arrLocationResults: [MKMapItem]!
    var pmEventPlace: MKPlacemark?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var mvLocation: MKMapView!
    @IBOutlet weak var tfEventAddress: UITextField!
    @IBOutlet weak var tfEventPlace: UITextField!
    @IBOutlet weak var tvAddressResult: UITableView!
    
    //MARK:- VIEW LIFECYCLE
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        tvAddressResult.isHidden = true
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tfEventAddress.placeholder = "SIVC_EVAD".localized
        tfEventAddress.delegate = self
        tfEventAddress.clearButtonMode = UITextFieldViewMode.always
        tfEventPlace.placeholder   = "SIVC_EVPL".localized
        tfEventPlace.delegate = self
        tfEventPlace.clearButtonMode = UITextFieldViewMode.always
        mvLocation.delegate = self
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
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - FUNCTIONS
    
    func centerMapOn(location: CLLocationCoordinate2D, span: MKCoordinateSpan?) {
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location,
                                                            span: span ?? MKCoordinateSpanMake(0.005,
                                                                                               0.005))
        mvLocation.setRegion(region,
                             animated: true)
    }
    
    func getLocalRequestFor(query: String) {
        
        let localRequest: MKLocalSearchRequest = MKLocalSearchRequest()
        localRequest.naturalLanguageQuery = query
        localRequest.region = mvLocation.region
        let search: MKLocalSearch = MKLocalSearch(request: localRequest)
        search.start { (response, err) in
            
            guard let places = response else { return }
            self.arrLocationResults = places.mapItems
            self.tvAddressResult.reloadData()
        }
    }
    
    //MARK: - ACTIONS

}

// MARK: - GMSMapViewDelegate,CLLocationManagerDelegate
extension LocationInfoVC: CLLocationManagerDelegate, MKMapViewDelegate {
    
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
        
        print(error)
    }
}

extension LocationInfoVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        tvAddressResult.isHidden = false
        getLocalRequestFor(query: textField.text! + string)
        return true
    }
}

extension LocationInfoVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrLocationResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell: LocationResultTVCell = tableView.dequeueReusableCell(withIdentifier: "LocationResultCell", for: indexPath) as! LocationResultTVCell
        aCell.currentLocation = arrLocationResults[indexPath.row]
        return aCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let aCell: LocationResultTVCell = tableView.cellForRow(at: indexPath) as! LocationResultTVCell
        tfEventAddress.text = aCell.textLabel?.text
        tfEventPlace.text = aCell.detailTextLabel?.text
        tvAddressResult.isHidden = true
        dismissKeyboard()
        pmEventPlace = aCell.currentLocation?.placemark
        mvLocation.removeAnnotations(mvLocation.annotations)
        let annEventPlace: MKPointAnnotation = MKPointAnnotation()
        annEventPlace.coordinate = pmEventPlace!.coordinate
        annEventPlace.title = pmEventPlace?.name
        mvLocation.addAnnotation(annEventPlace)
        mvLocation.showAnnotations(mvLocation.annotations, animated: true)
        
    }
}
