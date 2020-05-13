//
//  ChatDelegate.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 13/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
import Contacts
//MARK: - ChatDelegate
protocol ChatDelegate{
    

    func didSelect(_ viewController: ChatViewController, message bubble: MessageBubble, message : Message)
    func didSelectContactMessageBubble(_ viewController: ChatViewController, message bubble: ContactMessageBubble, message : Message)// when default contact cell is used
    func didLongPress(_ viewController: ChatViewController, message bubble: MessageBubble, message : Message)

    func didSendMessage(_ viewController: ChatViewController, message : Message, to receiver : Channel)
    func didSendAudioMessage(_ viewController: ChatViewController, message : Message, to receiver : Channel,localfile url : URL)
    func didSendPhotoMessage(_ viewController: ChatViewController, message : Message, to receiver : Channel, images : [UIImage])
    func didSendLocationMessage(_ viewController: ChatViewController, message : Message, to receiver : Channel)
    func didSendContactMessage(_ viewController: ChatViewController, message : Message, to receiver : Channel, contacts: [CNContact])
    func didSendFileMessage(_ viewController: ChatViewController, message : Message, to receiver : Channel, fileAt url: URL)

}


extension ChatDelegate {
    
    func didSelectContactMessageBubble(_ viewController: ChatViewController, message bubble: ContactMessageBubble, message : Message)
    {
        
    }
}
