//
//  MapViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
@_exported import MapKit
@_exported import CoreLocation

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView : MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
}
//MARK: - LOCATION
extension MapViewController {

    func addAnnotation(coordinate: CLLocationCoordinate2D){
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
    }
}
//MARK: - CURRENT LOCATION
extension MapViewController {
    
    func getCurrentLocation(){
        requestForLocationTracking()
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
                @unknown default:
                break
            }
        }
        else {
            alertForEnableLocation()
        }
        
    }
    func requestForLocationTracking(){
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
    }
}
