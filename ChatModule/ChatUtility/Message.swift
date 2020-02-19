//
//  MessageModel.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation
struct Message: Codable{
    
    
    var senderId : String
    var receiverId: String
    
    var message : String? = nil
    var audioMsg : String? = nil
    var videoMsg: String? = nil
    var imageMsg: String? = nil
    
    var sendDateTime : String
    var deliveryDateTime : String? = nil
    var readDateTime : String? = nil
    

    enum MsgStatus{
        case sent,deliver,read,notSent
    }
    enum MessageType{
        case text, image,video, audio, file
    }
    func getState( )->MsgStatus{
        if readDateTime?.count ?? 0 > 0 {
            return .read
        }
        else if deliveryDateTime?.count ?? 0 > 0{
            return .deliver
        }
        else if sendDateTime.count > 0{
            return .sent
        }
        return .notSent
    }
    func getMessageType()->MessageType{
        if self.audioMsg != nil{
            return .audio
        }
        if imageMsg != nil{
            return .image
        }
        if videoMsg != nil{
            return .video
        }
        return .text
    }
    
}

