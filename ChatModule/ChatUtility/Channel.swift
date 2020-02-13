//
//  User.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 11/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation

struct Channel: Codable {
    
    let name : String
    var id: String
    let profile: String
    let lastMessage : Message?
    var isGroup: Int = 0
    
}
