//
//  ChatScreenCoordinator.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 12/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import CoreLocation

typealias MessageBubble = MessageTableViewCell
typealias ContactMessageBubble = ContactMsgTableViewCell

protocol ChatScreenNavigator {
    func moveToLocationViewerScreen(_ viewController: ChatViewController, locations : [Location], sender: Channel)
}


class ChatScreenCoordinator {
    //MARK: - PROPERTIES

    private var navigationController :UINavigationController!
    private var receiver : Channel
    private var chatDelegate : ChatDelegate
    private var chatDataSource : ChatDataSource

    var dateManager : DateManager!
    var backCoordinator: BackNavigateDelegate
    var loginUser: Channel
    
    //MARK: - INITIALIZATION
    init(navigationController : UINavigationController,
         receiver : Channel,
         delegate : ChatDelegate,
         dataSource: ChatDataSource,
         backNavigator: BackNavigateDelegate,
         loginUser: Channel){
        
        self.navigationController = navigationController
        self.receiver = receiver
        chatDelegate = delegate
        chatDataSource = dataSource
        self.backCoordinator = backNavigator
        self.loginUser = loginUser
   }
    //MARK: - METHOD
    func start(){
        let chatViewController = ChatViewController.initiatefromStoryboard(.main)
        chatViewController.receiver = receiver
        chatViewController.dateManager = dateManager
        chatViewController.delegate = chatDelegate
        chatViewController.dataSource = chatDataSource
        chatViewController.backDelegate = backCoordinator
        chatViewController.navigator = self
        chatViewController.logInUser = loginUser
        navigationController.pushViewController(chatViewController, animated: true)
    }
}


extension ChatScreenCoordinator: ChatScreenNavigator {
    func moveToLocationViewerScreen(_ viewController: ChatViewController, locations: [Location], sender: Channel) {
        let coordinator = LocationViewerCoordinator(navigationController: navigationController, locations: locations, sender: sender, dateManager: dateManager)
        coordinator.start()
    }    
}
