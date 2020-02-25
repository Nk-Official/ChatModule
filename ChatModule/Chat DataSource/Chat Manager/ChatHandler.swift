//
//  ChatHandler.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 13/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Contacts
class ChatHandler {
    
    var firebaseManager = FireBaseManager()
    let fireBaseStorage = FirebaseStorageManager()
    var dateManager = DateManager(inputDateFormat: "MMM dd, yyyy hh:mm a", outputDateFormat: "MMM dd, yyyy", outputTimeFormat: "hh:mm a")
    var allMessages = [DayMessages]()
}
//MARK: - ChatDelegate
extension ChatHandler : ChatDelegate{
    
    func didSendPhotoMessage(_ viewController: ChatViewController, message: Message, to receiver: String, images: [UIImage]) {
        for image in images{
            fireBaseStorage.uploadImage(image: image) { (result) in
                switch result{
                case .success(let url):
                    var imageMsg = message
                    imageMsg.imageMsg = url.absoluteString
                    self.firebaseManager.sendMessage(toUser: receiver, message: imageMsg)
                    self.allMessages = self.firebaseManager.addMessage(message: imageMsg, ofdate: self.dateManager.getCurrentDate(), to: self.allMessages)
                    viewController.refresh(message: self.allMessages)
                case .failure(let error):fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    func didSendAudioMessage(_ viewController: ChatViewController, message: Message, to receiver: String, localfile url: URL) {
        
       fireBaseStorage.uploadAudio(localfile: url) { (result) in
            switch result{
            case .success(let url):
                var audioMsg = message
                audioMsg.audioMsg = url.absoluteString
                self.firebaseManager.sendMessage(toUser: receiver, message: audioMsg)
                self.allMessages = self.firebaseManager.addMessage(message: audioMsg, ofdate: self.dateManager.getCurrentDate(), to: self.allMessages)
                viewController.refresh(message: self.allMessages)
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
            DocumentDirectoryManager.deleteFileAtUrl(localFile: url)
        }
    }
    
    func didSelect(_ viewController: ChatViewController, message bubble: MessageBubble, message: Message) {
        
    }
    
    func didLongPress(_ viewController: ChatViewController, message bubble: MessageBubble, message: Message) {
        
    }
    func didSendMessage(_ viewController: ChatViewController, message: Message, to receiver: String) {
        firebaseManager.sendMessage(toUser: receiver, message: message)
        allMessages = firebaseManager.addMessage(message: message, ofdate: dateManager.getCurrentDate(), to: self.allMessages)
        viewController.refresh(message: allMessages)
    }
   func didSendLocationMessage(_ viewController: ChatViewController, message: Message, to receiver: String) {
        firebaseManager.sendMessage(toUser: receiver, message: message)
        allMessages = firebaseManager.addMessage(message: message, ofdate: dateManager.getCurrentDate(), to: self.allMessages)
        viewController.refresh(message: allMessages)
   }
    func didSendContactMessage(_ viewController: ChatViewController, message: Message, to receiver: String, contacts: [CNContact]) {
        
        do{
            let data = try CNContactVCardSerialization.data(with: contacts)
            fireBaseStorage.uploadContactData(data: data) { (result) in
                switch result{
                case .success(let url):
                    var msg = message
                    msg.contacts = url.absoluteString
                    self.firebaseManager.sendMessage(toUser: receiver, message: msg)
                    self.allMessages = self.firebaseManager.addMessage(message: msg, ofdate: self.dateManager.getCurrentDate(), to: self.allMessages)
                    viewController.refresh(message: self.allMessages)
                case .failure(let error):
                    print("error while sending contact",error.localizedDescription)
                }
            }
        }
        catch{
            debugPrint("error while converting contact to data",error.localizedDescription)
        }
    }
}

//MARK: - ChatDataSource
extension ChatHandler : ChatDataSource{
    
    
    func messages(_ viewcontroller: ChatViewController, receiver id: String, messages: @escaping ([DayMessages]) -> ()) {
        firebaseManager.getAllChat(of: id) { (list) in
            let daysMsgs = self.firebaseManager.splitMessagesaccordingToTime(all: list)
            messages(daysMsgs)
            self.allMessages = daysMsgs
        }
    }
    
}
