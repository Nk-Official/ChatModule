//
//  LocationMsgTavleViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//
import MapKit
import SDWebImage

class LocationMsgTavleViewCell:MessageTableViewCell {
    
    @IBOutlet weak var mapImgView : UIImageView!

    private var coordinates: CLLocationCoordinate2D!
    
    override func configureUI() {
        super.configureUI()
        if message == nil{return}
        let latitude = message.location?.latitude
        let longtitude = message.location?.longitude
        coordinates = CLLocationCoordinate2D(latitude: latitude!, longitude: longtitude!)
        setMapView(coordinates: coordinates)
        timeLbl.text = dateManager.getTime(from: message.sendDateTime)
        msgStateImgV.image = getMessageStateImg()
        
    }
}


//MARK: - LOCATION
extension LocationMsgTavleViewCell {
//https://dispatchswift.com/render-a-map-as-an-image-using-mapkit-3102a5a3fa5
    func setMapView(coordinates: CLLocationCoordinate2D?){

        if coordinates == nil{return}
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        // Set the region of the map that is rendered.
        let needleLocation = coordinates!
    
        let region = MKCoordinateRegion(center: needleLocation, latitudinalMeters: 500, longitudinalMeters: 500)
        mapSnapshotOptions.region = region

        // Set the scale of the image. We'll just use the scale of the current device, which is 2x scale on Retina screens.
        mapSnapshotOptions.scale = UIScreen.main.scale

        // Set the size of the image output.
        mapSnapshotOptions.size = CGSize(width: 300, height: 300)
        
        // Show buildings and Points of Interest on the snapshot
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = false
        
        let key = "map" + "\(coordinates!.latitude)+\(coordinates!.longitude)"
        let cache = SDImageCache.shared
        /// https://github.com/SDWebImage/SDWebImage/wiki/Advanced-Usage
        ///https://stackoverflow.com/questions/14902835/sdwebimage-download-image-and-store-to-cache-for-key
        if let image = cache.imageFromCache(forKey: key){
            self.mapImgView.image = image
        }
        else{
            MKMapSnapshotter.init(options: mapSnapshotOptions).start { (snapshot, error) in
                guard let image = snapshot?.image else{
                    return
                }
                var mapimage = image
                if let annotationImage = self.addAnnotation(image: image, snapshot: snapshot!, annotation: coordinates!){
                    mapimage = annotationImage
                }
                cache.store(mapimage, forKey: key, completion: nil)
                self.mapImgView.image = mapimage
            }
        }
    
    }
    func addAnnotation(image : UIImage, snapshot: MKMapSnapshotter.Snapshot, annotation coordinates: CLLocationCoordinate2D) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
        image.draw(at: .zero)
        let visibleRect = CGRect(origin: CGPoint.zero, size: image.size)
        let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
        var point = snapshot.point(for: coordinates)
        if visibleRect.contains(point){
            point.x = point.x + pin.centerOffset.x - (pin.bounds.size.width / 2)
            point.y = point.y + pin.centerOffset.y - (pin.bounds.size.height / 2)
            pin.image?.draw(at: point)
        }
        guard let compositeImage = UIGraphicsGetImageFromCurrentImageContext() else{
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return compositeImage
    }
}
