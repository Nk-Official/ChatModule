//
//  LocationManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import CoreLocation


class LocationManager: NSObject {
    
    //MARK: - ShareLocation
    enum ShareLocation{
        case live
        case coordinates
    }
    
    //MARK: - properties
    private var locationType: ShareLocation!
    private var locationManager: CLLocationManager = CLLocationManager()
    
    //MARK: - INIT
    init(location share: ShareLocation) throws{
        locationType = share
        super.init()
        do{
            try setUpLocationmanager()
        }
        catch(let error){
            throw error
        }
        
    }

    //MARK: - setUpLocationmanager
    func setUpLocationmanager() throws{
        requestForLocationTracking()
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                case .authorizedAlways, .authorizedWhenInUse:
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    locationManager.startUpdatingLocation()
                @unknown default:
                break
            }
        }
        else{
            throw CustomError.custom("location service not enable")
        }
    }
    func requestForLocationTracking(){
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
    }
}


//MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        switch locationType {
        case .live:break
        case .coordinates:
            locationManager.stopUpdatingLocation()
        case .none:
            locationManager.stopUpdatingLocation()
        }
    }
}
