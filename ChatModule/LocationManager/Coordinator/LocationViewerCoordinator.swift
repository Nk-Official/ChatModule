//
//  LocationViewerCoordinator.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 25/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
class LocationViewerCoordinator {
    
    private var navigationController :UINavigationController
    var locations: [Location]
    var dateManager: DateManager
    var sender: Channel
    
    init(navigationController : UINavigationController,
         locations: [Location],
         sender: Channel,
         dateManager : DateManager){
        self.navigationController = navigationController
        self.locations = locations
        self.dateManager = dateManager
        self.sender = sender
    }
    
    func start(){
        let locationViewer = LocationViewerViewController.initiatefromStoryboard(.main)
        locationViewer.locations = locations
        locationViewer.sender = sender
        locationViewer.dateManager = dateManager
        navigationController.navigationBar.isHidden = false
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.pushViewController(locationViewer, animated: true)
    }
}
