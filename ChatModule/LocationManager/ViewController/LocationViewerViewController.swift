//
//  LocationViewerViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class LocationViewerViewController: MapViewController {

    
    @IBOutlet weak var profileImgV  : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var upadtedTimeLbl : UILabel!
    //MARK: - IBACTION
    @objc func cancel(_ sender: UIButton){
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    var locations: [Location] = []
    var sender: Channel!
    var userid : String{
        return CommonFunctions.loginUserUdId()
    }
    var dateManager : DateManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        showLocationOnMap()
    }

    func setUI(){
        
        profileImgV.setImage(from: sender.profile)
        if sender.id == userid{
            
        }
        nameLbl.text = sender.id == userid ? "You" : sender.name
        upadtedTimeLbl.text = "Updated at: " +  (locations.last?.updateTime ?? "00:00")
        profileImgV.cornerRadius = profileImgV.frame.width/2
        
        
    }
    
    func setNavigationBar(){
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel(_:)))
        navigationItem.leftBarButtonItem =  leftBarButton
       
    }
    func showLocationOnMap(){
        for loc in locations{
            let location = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
            addAnnotation(coordinate: location)
        }
        if locations.count>0{
            let location = locations.first!
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
        }
    }
    
}
