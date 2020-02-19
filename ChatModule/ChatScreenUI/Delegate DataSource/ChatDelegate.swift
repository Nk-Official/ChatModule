//
//  ChatDelegate.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 13/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
//MARK: - ChatDelegate
protocol ChatDelegate{
    

    func didSelect(_ viewController: ChatViewController, message bubble: MessageBubble, message : Message)
    func didLongPress(_ viewController: ChatViewController, message bubble: MessageBubble, message : Message)
    
    func didSendMessage(_ viewController: ChatViewController, message : Message, to receiver : String)
    func didSendAudioMessage(_ viewController: ChatViewController, message : Message, to receiver : String,localfile url : URL)
    func didSendPhotoMessage(_ viewController: ChatViewController, message : Message, to receiver : String, images : [UIImage])

}
