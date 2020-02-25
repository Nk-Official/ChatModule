//
//  LocationViewerViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class LocationViewerViewController: MapViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var profileImgV  : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var upadtedTimeLbl : UILabel!
    //MARK: - IBACTION
    
    
    //MARK: - PROPERTIES
    var locations: [Location] = []
    var sender: Channel!
    var userid : String{
        return CommonFunctions.loginUserUdId()
    }
    var dateManager : DateManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUI()
        showLocationOnMap()
    }

    //MARK: - CONFIGURE UI
    func setUI(){
        
        profileImgV.setImage(from: sender.profile)
        if sender.id == userid{
            
        }
        nameLbl.text = sender.id == userid ? "You" : sender.name
        upadtedTimeLbl.text = "Updated at: " +  (locations.last?.updateTime ?? "00:00")
        profileImgV.cornerRadius = profileImgV.frame.width/2
        
        guard let updatedtime = locations.last?.updateTime else{
            return
        }
        guard let dateDiff = dateManager.daysFromTodaysDate(from: updatedtime) else{
            return
        }
        let time = dateManager.getTime(from: updatedtime)
        var title : String = ""
        switch dateDiff {
        case .today:title = "Today " + (time ?? "")
        case.yesterday:title = "Yesterday " + (time ?? "")
        case .gapFromToday(_):
            title = updatedtime
        }
        upadtedTimeLbl.text = "Updated at: " + title
    }
    
    func setNavigationBar(){
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss))
        navigationItem.leftBarButtonItem =  leftBarButton
       
    }
    @objc func dismiss(_ sender: UIButton){
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }
    //MARK: - CONFIGURE MAP
    func showLocationOnMap(){
        for loc in locations{
            let location = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
            addAnnotation(coordinate: location)
        }
        if locations.count>0{
            let location = locations.first!
            let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
}
