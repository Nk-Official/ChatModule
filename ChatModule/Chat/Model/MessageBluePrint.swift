//
//  MessageBluePrint.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 02/03/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
// Message.Swift class must implement MessageBluePrint protocol this help for custom message type

protocol MessageBluePrint: Codable{
    
    //MARK: - PROPERTIES
    var senderId : String {get set}
    var receiverId: String {get set}
    
    var message : String? {get set}// URL
    var audioMsg : String? {get set}// URL
    var videoMsg: String? {get set}// URL
    var imageMsg: String? {get set}// URL
    var location: Location? {get set}
    var contacts: String? {get set}// URL
    var file: String? {get set}// URL

    var sendDateTime : String {get set}
    var deliveryDateTime : String? {get set}
    var readDateTime : String? {get set}
    
}


protocol LocationBluePrint:Codable {
    var latitude: Double  {get set}
    var longitude: Double {get set}
    var live: Int {get set}
    var updateTime: String {get set}
}

//example of custom message 
struct ABD: Codable, MessageBluePrint{
    var senderId: String
    
    var receiverId: String
    
    var message: String?
    
    var audioMsg: String?
    
    var videoMsg: String?
    
    var imageMsg: String?
    
    var location: Location?
    
    var contacts: String?
    
    var file: String?
    
    var sendDateTime: String
    
    var deliveryDateTime: String?
    
    var readDateTime: String?
    
    
    
    
}
