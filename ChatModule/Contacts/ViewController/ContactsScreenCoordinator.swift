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
        
        let contactsViewController = ContactsViewController.initiatefromStoryboard(.main)
        contactsViewController.delegate = delegate
        contactsViewController.dataSource = dataSource
        contactsViewController.title = title
//        vc.navigationItem.rightBarButtonItem = rightButtonNavigationBar
        contactsViewController.navigationItem.leftBarButtonItem = leftButtonNavigationBar
        contactsViewController.dateManager = dateManager
        contactsViewController.prefrences = prefrences
        contactsViewController.navigator =  self
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationController.navigationBar.prefersLargeTitles = true
        contactsViewController.navigationItem.searchController = searchController
//        contactsViewController.navigationItem.hidesSearchBarWhenScrolling = false
        navigationController.pushViewController(contactsViewController, animated: true)
    }
    func setUpNavigatinControllerForList(){
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 32)
        ]
        navigationController.navigationBar.barTintColor = UIColor.white
    }
}

//MARK: - ContactsNavigator
extension ContactsScreenCoordinator :ContactsNavigator{
    func goToLoginScreen(_ viewController: ContactsViewController) {
        // following code dont add in source code
        let navigationcontroller = UINavigationController()
        let loginViewController = LogInViewController.initiatefromStoryboard(.example)
        navigationcontroller.viewControllers = [loginViewController]
        if let window = UIApplication.shared.delegate?.window {
            window?.rootViewController = navigationcontroller
            window?.makeKeyAndVisible()
            window?.makeKey()
        }
    }
    
    func navigateToChat(_ viewController: ContactsViewController, receiver: Channel) {
//        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.prefersLargeTitles = false
        let chatHandler = ChatHandler()
        dataSource!.currentUser(viewController) { (user) in
            let coordinator = ChatScreenCoordinator(navigationController: self.navigationController, chatChannel: receiver, delegate: chatHandler, dataSource: chatHandler, backNavigator: self, loginUser: user)
            coordinator.dateManager = self.dateManager
            coordinator.start()
        }
    }
}

extension ContactsScreenCoordinator :BackNavigateDelegate{
    func moveBackScreen(from viewcontroller: UIViewController) {
//        navigationController.navigationBar.isHidden = false
        navigationController.popViewController(animated: true)
    }
}



//MARK: - ContactsNavigator
protocol ContactsNavigator {
    func navigateToChat(_ viewController : ContactsViewController, receiver: Channel)
    func goToLoginScreen(_ viewController : ContactsViewController)
}
