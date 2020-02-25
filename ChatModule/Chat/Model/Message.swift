//
//  MessageModel.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation
struct Message: Codable{
    
    //MARK: - PROPERTIES
    var senderId : String
    var receiverId: String
    
    var message : String? = nil// URL
    var audioMsg : String? = nil// URL
    var videoMsg: String? = nil// URL
    var imageMsg: String? = nil// URL
    var location: Location? = nil
    var contacts: String? = nil// URL
    
    var sendDateTime : String
    var deliveryDateTime : String? = nil
    var readDateTime : String? = nil
    
    //MARK: - HELPER
    enum MsgStatus{
        case sent,deliver,read,notSent
    }
    enum MessageType{
        case text, image,video, audio, file, location, contact
    }
    //MARK: - FUNCTIONS
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
        if location != nil{
            return .location
        }
        if contacts != nil{
            return .contact
        }
        return .text
    }
    
}
//MARK: - Location
struct Location : Codable{
    let latitude: Double
    let longitude: Double
    let live: Int
    let updateTime: String
}
