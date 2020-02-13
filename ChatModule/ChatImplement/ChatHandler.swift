//
//  ChatHandler.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 13/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
class ChatHandler {
    
    var firebaseManager = FireBaseManager()
    
}
//MARK: - ChatDelegate
extension ChatHandler : ChatDelegate{
    func didSelect(_ viewController: ChatViewController, message bubble: MessageBubble, message: Message) {
        
    }
    
    func didLongPress(_ viewController: ChatViewController, message bubble: MessageBubble, message: Message) {
        
    }
    
    func didSendMessage(_ viewController: ChatViewController, message: Message) {
        
    }
}

//MARK: - ChatDataSource
extension ChatHandler : ChatDataSource{
    func messages(_ viewcontroller: ChatViewController, receiver id: String, messages: ([DayMessages]) -> ()) {
        firebaseManager.getAllChat(of: id) { (list) in
            let daysMsgs = self.firebaseManager.splitMessagesaccordingToTime(all: list)
            messages(daysMsgs)
        }
    }
    
    func chatMessages(_ viewController: ChatViewController, receiver id : String, messages: (([DayMessages])->())?){
          
    }
    func incomingTextMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    func incomingAudioMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    func incomingVideoMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    func incomingImageMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    func outgoingTextMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    func outgoingAudioMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    func outgoingVideoMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    func outgoingImageMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    
}
