//
//  LocationMsgTavleViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//
import MapKit
class LocationMsgTavleViewCell:MessageTableViewCell {
    
    @IBOutlet weak var mapView : MKMapView!
    private var coordinates: CLLocationCoordinate2D!
    
    override func configureUI() {
        super.configureUI()
        if message == nil{return}
        let latitude = message.location?.latitude
        let longtitude = message.location?.longitude
        coordinates = CLLocationCoordinate2D(latitude: latitude!, longitude: longtitude!)
        
        mapView.setCenter(coordinates, animated: true)
        addAnnotation(coordinate: coordinates)
        timeLbl.text = dateManager.getTime(from: message.sendDateTime)
        msgStateImgV.image = getMessageStateImg()
    }
}


//MARK: - LOCATION
extension LocationMsgTavleViewCell {

    func addAnnotation(coordinate: CLLocationCoordinate2D){
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
    }
}
