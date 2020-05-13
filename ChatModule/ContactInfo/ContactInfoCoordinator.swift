//
//  ContactInfoCoordinator.swift
//  ChatModule
//
//  Created by user on 13/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
class ContactInfoCoordinator{
    
    private var navigationController :UINavigationController!

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start(){
        
        let infoViewController = ContactInfoViewController.initiatefromStoryboard(.main)
        navigationController.pushViewController(infoViewController, animated: true)
    }
}
