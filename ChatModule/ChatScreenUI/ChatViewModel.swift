//
//  ChatViewModel.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import RxSwift
import RxCocoa
class ChatViewModel {
    
    var userId : String
    var messages: BehaviorRelay<[DayMessages]> =  BehaviorRelay (value: [])
    var lastIndex : IndexPath{
        let lastRow = messages.value.count - 1
        return IndexPath(row: lastRow, section: 0)
    }
    init(userId: String) {
        self.userId = userId
    }
    private func getAllMessages()->[Message]{
//
//        let msg1 = Message(message: "Hey There?", senderId: "123", sendTime: "10:10 am", deliveryTime: "10:11 am", readTime: "10:20 am")
//        let msg2 = Message(message: "me and amy are going to see new jurassic world moview. wanna come?", senderId: "123", sendTime: "10:11 am", deliveryTime: "10:12 am", readTime: "10:20 am")
//        let msg3 = Message(message: "we will grab food before the movie start", senderId: "123", sendTime: "10:12 am", deliveryTime: "10:13 am", readTime: "10:20 am")
//        let msg4 = Message(message: "See you there?", senderId: "1234", sendTime: "10:10 am", deliveryTime: "10:11 am", readTime: "10:20 am")
//        let msg5 = Message(message: "Hi ", senderId: "123", sendTime: "10:20 am", deliveryTime: "10:21 am", readTime: "")
//        let msg6 = Message(message: "Hey There?", senderId: "1234", sendTime: "10:20 am", deliveryTime: "", readTime: "")
//        let msg7 = Message(message: "me and amy are going to see new jurassic world moview. wanna come?", senderId: "1234", sendTime: "10:20 am", deliveryTime: "", readTime: "")
//        let msg8 = Message(message: "Hi, Chris your recent shot is really great i like this style very much!", senderId: "123", sendTime: "10:20 am", deliveryTime: "10:21 am", readTime: "")
//        let msg9 = Message(message: "Send me a book.", senderId: "1234", sendTime: "10:10 am", deliveryTime: "", readTime: "")
//        let msg10 = Message(message: "Where?", senderId: "1234", sendTime: "10:10 am", deliveryTime: "", readTime: "")
//
//
//        return [msg1,msg2,msg3,msg4,msg5,msg6,msg7,msg8,msg9,msg10]
        return []
    }
    func reuseId(msg :  Message)->String{
        // message is send from myside
        if msg.senderId == self.userId{
            switch msg.getMessageType(){
            case .text:
                return "outgoingcell"
            case .audio:
                return "OutgoingAudioMsgBubble"
            default:
                return ""
            }
            
        }
            // message is received from otherside
        else{
            switch msg.getMessageType(){
            case .text:
                return "incomingcell"
            case .audio:
                return "OutgoingAudioMsgBubble"
            default:
                return ""
            }
            
        }
    }
}
