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
    var title : String? = "Chats"
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
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationController.navigationBar.prefersLargeTitles = true
        vc.navigationItem.searchController = searchController
        
        navigationController.pushViewController(vc, animated: true)

    }
    func setUpNavigatinControllerForList(){
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 32)
        ]
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.setNavigationBarHidden(!showNavigationBar, animated: true)
    }
}

//MARK: - ContactsNavigator
extension ContactsScreenCoordinator :ContactsNavigator{
    func navigateToChat(_ viewController: ContactsViewController, receiver: Channel) {
        navigationController.navigationBar.isHidden = true
        let chatHandler = ChatHandler()
        let coordinator = ChatScreenCoordinator(navigationController: navigationController, receiver: receiver, delegate: chatHandler, dataSource: chatHandler, backNavigator: self)
        coordinator.dateManager = dateManager
        
        coordinator.start()
    }
    
}
extension ContactsScreenCoordinator :BackNavigateDelegate{
    func moveBackScreen(from viewcontroller: UIViewController) {
        navigationController.navigationBar.isHidden = false
        navigationController.popViewController(animated: true)
    }
}
//MARK: - ContactsDataSource
protocol ContactsDataSource {
    func contactsList(_ viewController: ContactsViewController, contacts list : @escaping (([Channel])->()))
    func cellForRowAt(_ viewController: ContactsViewController,for user : Channel, at row : Int)->UITableViewCell?
    func startRefreshing(_ viewController: ContactsViewController, completion : @escaping ([Channel])->())
}

//MARK: - ContactsDelegate
protocol ContactsDelegate {
    func createGroup(_ viewController: ContactsViewController, group channel : Channel)
    func didSelectContact(_ viewController: ContactsViewController, contact : Channel)
    
}

//MARK: - ContactsNavigator
protocol ContactsNavigator {
    func navigateToChat(_ viewController : ContactsViewController, receiver: Channel)
}
