//
//  ContactsScreen.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 12/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
open class ContactsScreenCoordinator {
    
    //MARK: - PROPERTIES
    private var navigationController :UINavigationController!
    private var delegate :ContactsDelegate?
    private var dataSource :ContactsDataSource?
    var title : String? = "Let's Talk"
    var showNavigationBar : Bool = true
    var rightButtonNavigationBar : UIBarButtonItem?
    var leftButtonNavigationBar : UIBarButtonItem?
    var dateManager :  DateManager!
    var prefrences: ContactsPrefrences = ContactsPrefrences()
    //MARK: - INITIALIZATION
    init(navigationController : UINavigationController, delegate : ContactsDelegate?, dataSource : ContactsDataSource, datemanager : DateManager?){
        self.navigationController = navigationController
        self.delegate =  delegate
        self.dataSource =  dataSource
        self.dateManager = dateManager ?? DateManager(inputDateFormat: "MMM dd, yyyy hh:mm a", outputDateFormat: "MMM dd, yyyy", outputTimeFormat: "hh:mm a")
    }
    
    //MARK: - METHOD
    func start(){
        
        let vc = ContactsViewController.initiatefromStoryboard(.main)
        vc.delegate = delegate
        vc.dataSource = dataSource
        vc.title = title
//        vc.navigationItem.rightBarButtonItem = rightButtonNavigationBar
        vc.navigationItem.leftBarButtonItem = leftButtonNavigationBar
        vc.dateManager = dateManager
        vc.prefrences = prefrences
        vc.navigator =  self
        navigationController.setNavigationBarHidden(!showNavigationBar, animated: true)
        navigationController.pushViewController(vc, animated: true)

    }
    
    
}

extension ContactsScreenCoordinator :ContactsNavigator{
    func navigateToChat(_ viewController: ContactsViewController, receiverId: String) {
        let coordinator = ChatScreenCoordinator(navigationController: navigationController, receiverId: receiverId, dataSource: ChatHandler())
        coordinator.dateManager = dateManager
        coordinator.start()
    }
}

//MARK: - ContactsDataSource
protocol ContactsDataSource {
    func contactsList(_ viewController: ContactsViewController, contacts list : @escaping (([Channel])->()))
    func cellForRowAt(_ viewController: ContactsViewController,for user : Channel, at indexPath : IndexPath)->UITableViewCell?
    func startRefreshing(_ viewController: ContactsViewController, completion : @escaping ([Channel])->())
}

//MARK: - ContactsDelegate
protocol ContactsDelegate {
    func createGroup(_ viewController: ContactsViewController, group channel : Channel)
    func didSelectContact(_ viewController: ContactsViewController, contact : Channel)
    
}

//MARK: - ContactsNavigator
protocol ContactsNavigator {
    func navigateToChat(_ viewController : ContactsViewController, receiverId: String)
}
