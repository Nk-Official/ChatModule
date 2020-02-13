//
//  Group.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 12/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
struct Group: Codable {
    
    let name : String
    let profile: String?
    let id: String
    let member: [Member]
    let lastMessage: Message
}

struct Member: Codable{
    let name : String
    let id : String
    let profile: String?
    
}
