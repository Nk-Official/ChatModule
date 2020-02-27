//
//  LocationViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 20/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
protocol LocationPickerDelegate{
    func didPickLocation(_ viewController: LocationPickerViewController, coordinates: CLLocationCoordinate2D, isLive: Bool)
}


class LocationPickerViewController: MapViewController {

   //MARK: - IBOUTLET
    @IBOutlet weak var mapViewHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var scrollView : UIScrollView!

   //MARK: - IBACTION
  
    @IBAction func refresh(_ sender: UIButton){
        
    }
    @IBAction func shareLiveLocation(_ sender: UIButton){
        if currentLocationCoordinates == nil{
            //alert for enable location service
            return
        }
        delegate?.didPickLocation(self, coordinates: currentLocationCoordinates!, isLive: true)
    }
    @IBAction func shareCurrentLocation(_ sender: UIButton){
        if currentLocationCoordinates == nil{
            //alert for enable location service
            return
        }
        delegate?.didPickLocation(self, coordinates: currentLocationCoordinates!, isLive: false)
    }
    @IBAction func sendMessage(_ sender: UIButton){
    
    }
   //MARK: - VARIABLES
    private let heigthMapView: CGFloat = 400
    
    var delegate: LocationPickerDelegate?
    private var currentLocationCoordinates: CLLocationCoordinate2D?
   //MARK: - OVERRIDEN
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        locationManager.delegate = self
    }
   //MARK: - UI SETUP
   func setUI(){
        scrollView.delegate = self
        getCurrentLocation()
        setNavigationBar()
   }
    func setNavigationBar(){
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss))
        navigationItem.leftBarButtonItem =  leftBarButton
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = rightBarButton
        
        navigationItem.searchController?.searchBar.delegate = self
    }
    @objc func dismiss(_ sender: UIButton){
       pop()
      }
    func pop(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)
    }
   //MARK: - NETWORK CALL

    
}




//MARK: - CLLocationManagerDelegate
extension LocationPickerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let center = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        currentLocationCoordinates = center
        mapView.setRegion(region, animated: true)
        print("location",center)
        addAnnotation(coordinate: center)
    }
}

//MARK: - UIScrollViewDelegate
extension LocationPickerViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        UIView.animate(withDuration: 0.2) {
            self.mapViewHeightConstraint.constant = self.heigthMapView - offset
        }
    }
}


extension LocationPickerViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
