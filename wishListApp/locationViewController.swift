//
//  locationViewController.swift
//  wishListApp
//
//  Created by Christopher Canales on 4/17/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit
import MapKit

class locationViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate,  UITableViewDataSource, CLLocationManagerDelegate {
    
    /*, UINavigationControllerDelegate**/
    var matchingLocations:[MKMapItem] = []
    var selectedLoc:MKMapItem?
    var manager:CLLocationManager!
    
    

    @IBOutlet weak var locSearchLabel: UITextField!
    @IBOutlet weak var matchingItemTableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        matchingItemTableView.rowHeight = 65
        locSearchLabel.addDoneButtonOnKeyboard()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = matchingItemTableView.dequeueReusableCell(withIdentifier: "matchingLocCell", for: indexPath) as! matchingLocTableViewCell
        cell.aMatchingLoc.text = (matchingLocations[indexPath.row].name)!
        cell.matchingLocAdress.text = (matchingLocations[indexPath.row].placemark.title)!
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.map.removeAnnotations(self.map.annotations)
        self.selectedLoc = matchingLocations[indexPath.row]
        let theCoor = self.selectedLoc?.placemark.coordinate
        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: theCoor!, span: span)
        self.map.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
                annotation.coordinate = theCoor!
        annotation.title = self.selectedLoc?.placemark.name
        //        annotation.subtitle = "
                self.map.addAnnotation(annotation)
    }
    
    @IBAction func locSearch(_ sender: UIButton) {
        map.removeAnnotations(map.annotations)
        
            let theRequest = MKLocalSearch.Request()
            theRequest.naturalLanguageQuery = locSearchLabel.text
            theRequest.region = map.region
                    //                request.region =
                    let search = MKLocalSearch(request: theRequest)
                                    
                    search.start{ response, _ in guard
                        let response = response else{
                            return
                            
                        }
                        
                        let theCoor = response.mapItems[0].placemark.coordinate
                        let span: MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.5, longitudeDelta: 0.5)
                        
                        let region: MKCoordinateRegion = MKCoordinateRegion.init(center: theCoor, span: span)
                        self.map.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                                annotation.coordinate = theCoor
                        annotation.title = response.mapItems[0].placemark.name
                        //        annotation.subtitle = "
                                self.map.addAnnotation(annotation)
                        
                        self.matchingLocations = response.mapItems
                        self.matchingItemTableView.reloadData()
                    }
        
    }
    @IBAction func addLoc(_ sender: UIBarButtonItem) {
        if let aSelectedLocation = self.selectedLoc {
//            goBackfunc()
        }
        else{
            let alert = UIAlertController(title: "Must Select a location", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
    }
    
    @IBAction func showMap(_ sender: UISegmentedControl) {
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
        
        case 1:
           map.mapType = MKMapType.satellite
        
        case 2:
           map.mapType = MKMapType.hybrid
            
        default:
            map.mapType = MKMapType.standard
        }
    }
    
    
    func goBackfunc(){
         navigationController?.popViewController(animated: true)
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

