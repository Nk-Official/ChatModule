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
    
    fileprivate func sendMessage(message: Message, receiver: Channel){
        if receiver.isGroup == 1{
            firebaseManager.sendMessageToGroup(toGroup: receiver.id, message: message)
        }else{
            firebaseManager.sendMessage(toUser: receiver.id, message: message)
        }
    }
}
//MARK: - ChatDelegate
extension ChatHandler : ChatDelegate{
    
    func didSendPhotoMessage(_ viewController: ChatViewController, message: Message, to receiver: Channel, images: [UIImage]) {
        for image in images{
            fireBaseStorage.uploadImage(image: image) { (result) in
                switch result{
                case .success(let url):
                    var imageMsg = message
                    imageMsg.imageMsg = url.absoluteString
                    self.sendMessage(message: imageMsg, receiver: receiver)
                    self.allMessages = self.firebaseManager.addMessage(message: imageMsg, ofdate: self.dateManager.getCurrentDate(), to: self.allMessages)
                    viewController.refresh(message: self.allMessages)
                case .failure(let error):fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    func didSendAudioMessage(_ viewController: ChatViewController, message: Message, to receiver: Channel, localfile url: URL) {
        
       fireBaseStorage.uploadAudio(localfile: url) { (result) in
            switch result{
            case .success(let url):
                var audioMsg = message
                audioMsg.audioMsg = url.absoluteString
                self.sendMessage(message: audioMsg, receiver: receiver)
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
    func didSelectContactMessageBubble(_ viewController: ChatViewController, message bubble: ContactMessageBubble, message : Message){
        guard let contacts = bubble.contacts else{
            return
        }
        
    }
    func didLongPress(_ viewController: ChatViewController, message bubble: MessageBubble, message: Message) {
        
    }
    func didSendMessage(_ viewController: ChatViewController, message: Message, to receiver: Channel) {
        self.sendMessage(message: message, receiver: receiver)
        allMessages = firebaseManager.addMessage(message: message, ofdate: dateManager.getCurrentDate(), to: self.allMessages)
        viewController.refresh(message: allMessages)
    }
   func didSendLocationMessage(_ viewController: ChatViewController, message: Message, to receiver: Channel) {
        self.sendMessage(message: message, receiver: receiver)
        allMessages = firebaseManager.addMessage(message: message, ofdate: dateManager.getCurrentDate(), to: self.allMessages)
        viewController.refresh(message: allMessages)
   }
    func didSendContactMessage(_ viewController: ChatViewController, message: Message, to receiver: Channel, contacts: [CNContact]) {
        
        do{
            let data = try CNContactVCardSerialization.data(with: contacts)
            fireBaseStorage.uploadContactData(data: data) { (result) in
                switch result{
                case .success(let url):
                    var msg = message
                    msg.contacts = url.absoluteString
                    self.sendMessage(message: msg, receiver: receiver)
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
    func didSendFileMessage(_ viewController: ChatViewController, message: Message, to receiver: Channel, fileAt url: URL) {
        fireBaseStorage.uploadFileData(fileat: url) { (result) in
            switch result{
            case .success(let url):
                var msg = message
                msg.file = url.absoluteString
                self.sendMessage(message: msg, receiver: receiver)
                self.allMessages = self.firebaseManager.addMessage(message: msg, ofdate: self.dateManager.getCurrentDate(), to: self.allMessages)
                viewController.refresh(message: self.allMessages)
            case .failure(let error):
                print("error while sending contact",error.localizedDescription)
                fatalError(error.localizedDescription)
            }
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
