//
//  EventFeedDetailVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/12/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import MapKit

class EventFeedDetailVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var currentEvent: Event?
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var tvEventDetail: UITableView!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        let btnBack: UIButton = UIButton(type: UIButton.ButtonType.system)
        btnBack.frame = CGRect(x: 0,
                               y: 40,
                               width: 50,
                               height: 50)
        btnBack.tintColor = UIColor.white
        btnBack.backgroundColor = UIColor.clear
        btnBack.setImage(#imageLiteral(resourceName: "ICBack"),
                         for: UIControl.State.normal)
        btnBack.addTarget(self,
                          action: #selector(self.actGoBack), for: UIControl.Event.touchUpInside)
        self.view.addSubview(btnBack)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - NAVIGATION
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowMoreComments"{
            
            let destinationVC = segue.destination as! MoreCommentsVC
            destinationVC.currentComments = Comment.getcomments()
        }
    }
    
    //MARK: - FUNCTIONS
    
    @objc func actGoBack() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func addToFavorites(anEvent: Event){
        
        //TODO: ADD EVENT TO FAVORITES
    }
    
    func assitToEvent(anEvent: Event){
        
        //TODO: ADD EVENT TO ASSIST LIST
    }
    
    func shareEvent(anEvent: Event){
        
        let strToShare = "EVFD_SH1".localized + "\(anEvent.eveName)" + "EVFD_SH2".localized + "\(anEvent.eveDate) \(anEvent.eveSchedule)" + "EVFD_SH3".localized + "\(anEvent.evePlace)."
        
        if let eventWebSite = NSURL(string: anEvent.eveURL) {
            let objectsToShare: [Any] = [strToShare, eventWebSite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = tvEventDetail
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func showNavigationOptions(){
        
        let navOptionsAlert: UIAlertController = UIAlertController(title: "EVFD_NAV_TIT".localized,
                                                                   message: "EVFD_NAV_MESS".localized,
                                                                   preferredStyle: UIAlertController.Style.actionSheet)
        if  let anEvent = self.currentEvent{
            
            self.getLocationFrom(anEvent: anEvent) { (location, error) in
                
                if let aLocation = location{
                    
                    let actMaps: UIAlertAction = UIAlertAction(title: "Maps",
                                                               style: UIAlertAction.Style.default) { (alert) in
                                                                
                                                                let regionDistance: CLLocationDistance = 10000
                                                                let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(aLocation.latitude, aLocation.longitude)
                                                                let regionSpan: MKCoordinateRegion = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
                                                                let options: [String: NSValue] = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                                                                                                  MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                                                                let placemark: MKPlacemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                                                                let mapItem: MKMapItem = MKMapItem(placemark: placemark)
                                                                mapItem.name = anEvent.evePlace
                                                                mapItem.openInMaps(launchOptions: options)
                    }
                    navOptionsAlert.addAction(actMaps)
                    
                    if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)){
                        
                        let actGoogleMaps: UIAlertAction = UIAlertAction(title: "Google Maps",
                                                                         style: UIAlertAction.Style.default) { (alert) in
                                                                            
                                                                            UIApplication.shared.open(URL(string: "comgooglemaps://?daddr=\(aLocation.latitude),\(aLocation.longitude)&zoom=14&directionsmode=driving")!,
                                                                                                      options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]),
                                                                                                      completionHandler: { (canOpenURL) in
                                                                                                        
                                                                                                        if !canOpenURL{
                                                                                                            let errorAlert: UIAlertController = UIAlertController(title: "ERROR",
                                                                                                                                                                  message: "There's a problem with the location.",
                                                                                                                                                                  preferredStyle: UIAlertController.Style.alert)
                                                                                                            errorAlert.addAction(UIAlertAction(title: "OK",
                                                                                                                                               style: UIAlertAction.Style.destructive,
                                                                                                                                               handler: nil))
                                                                                                            self.present(errorAlert, animated: true, completion: nil)
                                                                                                        }
                                                                            })
                        }
                        navOptionsAlert.addAction(actGoogleMaps)
                    }
                    
                    if (UIApplication.shared.canOpenURL(URL(string: "https://waze.com/ul")!)){
                        
                        let actWaze: UIAlertAction = UIAlertAction(title: "Waze",
                                                                   style: UIAlertAction.Style.default) { (alert) in
                                                                    
                                                                    UIApplication.shared.open(URL(string: "https://waze.com/ul?ll=\(aLocation.latitude),\(aLocation.longitude)&navigate=yes")!,
                                                                                              options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]),
                                                                                              completionHandler: { (canOpenURL) in
                                                                                                
                                                                                                if !canOpenURL{
                                                                                                    let errorAlert: UIAlertController = UIAlertController(title: "ERROR",
                                                                                                                                                          message: "There's a problem with the location.",
                                                                                                                                                          preferredStyle: UIAlertController.Style.alert)
                                                                                                    errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil))
                                                                                                    self.present(errorAlert, animated: true, completion: nil)
                                                                                                }
                                                                    })
                        }
                        navOptionsAlert.addAction(actWaze)
                    }
                }
            }
        }
        
        let actCancel: UIAlertAction = UIAlertAction(title: "CANCEL".localized,
                                                     style: UIAlertAction.Style.cancel,
                                                     handler: nil)
        navOptionsAlert.addAction(actCancel)
        present(navOptionsAlert, animated: true, completion: nil)
    }
    
    func getLocationFrom(anEvent: Event, completion: @escaping(_ location: CLLocationCoordinate2D?, _ error: Error?)->Void){
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(anEvent.eveAddress) { (placemarks, error) in
            
            if let error = error{
                
                completion(nil, error)
            }
            
            if let placemarks = placemarks{
                
                let placemark = placemarks[0]
                return completion(placemark.location?.coordinate, nil)
            }
        }
    }
}

//MARK: - EXTENSIONS

extension EventFeedDetailVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return 480
            
        case 1:
            return 150
            
        case 2:
            return 250
            
        case 3:
            return 297
            
        default:
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let aCell: EventDetailTVCell = tableView.dequeueReusableCell(withIdentifier: "EventDetailCell", for: indexPath) as! EventDetailTVCell
            aCell.addFavorite = {
                
                (selectedEvent) in
                self.addToFavorites(anEvent: selectedEvent)
            }
            aCell.assistEvent = {
                
                (selectedEvent) in
                self.assitToEvent(anEvent: selectedEvent)
            }
            aCell.shareEvent = {
                
                (selectedEvent) in
                self.shareEvent(anEvent: selectedEvent)
            }
            return aCell
            
        case 1:
            let aCell: EventInfoTVCell = tableView.dequeueReusableCell(withIdentifier: "EventInfoCell", for: indexPath) as! EventInfoTVCell
            return aCell
            
        case 2:
            let aCell: EventAddressTVCell = tableView.dequeueReusableCell(withIdentifier: "EventAddressCell", for: indexPath) as! EventAddressTVCell
            aCell.howToGetThereAction = {
                
                self.showNavigationOptions()
            }
            return aCell
            
        case 3:
            let aCell: CommentsTVCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsTVCell
            aCell.moreCommentsAction = {
                
                self.performSegue(withIdentifier: "ShowMoreComments", sender: self)
            }
            return aCell
            
        default:
            let aCell: OrganizersTVCell = tableView.dequeueReusableCell(withIdentifier: "OrganizersCell", for: indexPath) as! OrganizersTVCell
            return aCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            
        case 0:
            let aCell: EventDetailTVCell = cell as! EventDetailTVCell
            aCell.currentEvent = currentEvent
            
        case 1:
            let aCell: EventInfoTVCell = cell as! EventInfoTVCell
            aCell.currentEvent = currentEvent
            
        case 2:
            let aCell: EventAddressTVCell = cell as! EventAddressTVCell
            aCell.currentEvent = currentEvent
            
        case 3:
            let aCell: CommentsTVCell = cell as! CommentsTVCell
            aCell.currentCommentaries = Comment.getcomments()
            
        case 4:
            let aCell: OrganizersTVCell = cell as! OrganizersTVCell
            aCell.arrOrganizers = Organizer.getAllOrganizers()
            
        default:
            break
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
