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
    private var receiverId : String
    private var chatDelegate : ChatDelegate?
    private var chatDataSource : ChatDataSource

    var dateManager : DateManager!
    
    
    //MARK: - INITIALIZATION
    init(navigationController : UINavigationController,
         receiverId : String,
         delegate : ChatDelegate? = nil,
         dataSource: ChatDataSource){
       self.navigationController = navigationController
        self.receiverId = receiverId
        chatDelegate = delegate
        chatDataSource = dataSource
   }
    //MARK: - METHOD
    func start(){
        let vc = ChatViewController.initiatefromStoryboard(.main)
        vc.receiverId = receiverId
        vc.dateManager = dateManager
        navigationController.pushViewController(vc, animated: true)
    }
}

//MARK: - ChatDataSource
protocol ChatDataSource {
    
    func messages(_ viewcontroller: ChatViewController,receiver id : String, messages: ([DayMessages])->())
    
    func incomingTextMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func incomingAudioMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func incomingVideoMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func incomingImageMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    
    func outgoingTextMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func outgoingAudioMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func outgoingVideoMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func outgoingImageMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    
}

//MARK: - ChatDelegate
protocol ChatDelegate{
    

    func didSelect(_ viewController: ChatViewController, message bubble: MessageBubble, message : Message)
    func didLongPress(_ viewController: ChatViewController, message bubble: MessageBubble, message : Message)
    
    func didSendMessage(_ viewController: ChatViewController, message : Message)

}
