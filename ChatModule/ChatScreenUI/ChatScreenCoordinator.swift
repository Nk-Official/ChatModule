//
//  ChatScreenCoordinator.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 12/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation

typealias MessageBubble = MessageTableViewCell



class ChatScreenCoordinator {
    //MARK: - PROPERTIES

    private var navigationController :UINavigationController!
    private var receiver : Channel
    private var chatDelegate : ChatDelegate
    private var chatDataSource : ChatDataSource

    var dateManager : DateManager!
    var backCoordinator: BackNavigateDelegate
    
    //MARK: - INITIALIZATION
    init(navigationController : UINavigationController,
         receiver : Channel,
         delegate : ChatDelegate,
         dataSource: ChatDataSource,
         backNavigator: BackNavigateDelegate ){
        
        self.navigationController = navigationController
        self.receiver = receiver
        chatDelegate = delegate
        chatDataSource = dataSource
        self.backCoordinator = backNavigator
        
   }
    //MARK: - METHOD
    func start(){
        let vc = ChatViewController.initiatefromStoryboard(.main)
        vc.receiver = receiver
        vc.dateManager = dateManager
        vc.delegate = chatDelegate
        vc.dataSource = chatDataSource
        vc.backDelegate = backCoordinator
        navigationController.pushViewController(vc, animated: true)
    }
}


