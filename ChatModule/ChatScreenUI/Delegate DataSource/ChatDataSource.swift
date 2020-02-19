//
//  ChatDataSource.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 13/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
//MARK: - ChatDataSource
protocol ChatDataSource {
    
    func messages(_ viewcontroller: ChatViewController,receiver id : String, messages: @escaping ([DayMessages])->())
    
    func incomingTextMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func incomingAudioMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func incomingVideoMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func incomingImageMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func incomingFileMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?

    func outgoingTextMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func outgoingAudioMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func outgoingVideoMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func outgoingImageMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?
    func outgoingFileMessageBubble(_ viewController: ChatViewController, message: Message)->MessageBubble?

}

extension ChatDataSource{
    
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
    func incomingFileMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
    func outgoingFileMessageBubble(_ viewController: ChatViewController, message: Message) -> MessageBubble? {
        return nil
    }
    
}
