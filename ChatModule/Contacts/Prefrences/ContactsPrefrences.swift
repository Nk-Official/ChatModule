//
//  ContactsPrefrences.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 13/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

struct ContactsPrefrences {
    
    var muteIcon : UIImage?
    var showMuteOption: Bool
    
    var showDate: Bool
    var dateColor: UIColor
    var dateFont: UIFont

    var showLastMessage: Bool
    var lastMessageColor: UIColor
    var lastMessageFont: UIFont
    
    var showName: Bool
    var nameColor: UIColor
    var nameFont: UIFont
    
    var showUnreadMessagesCount: Bool
    var unreadMessageCountColor: UIColor
    var unreadMessageCountFont: UIFont
    var unreadMessageCountBackgroundColor: UIColor
    
    var showProfileIcon: Bool
    
    var seperatorColor: UIColor
    var showSeperator: Bool
}

//MARK: - INITIALIZATION

extension ContactsPrefrences {
    
    init() {
        muteIcon = UIImage(named: "notSpeaker")
        showMuteOption = true
        showDate = true
        dateColor = UIColor(displayP3Red: 123/255, green: 123/255, blue: 123/255, alpha: 1)
        dateFont = UIFont.systemFont(ofSize: 16)
        showLastMessage = true
        lastMessageColor = UIColor(displayP3Red: 123/255, green: 123/255, blue: 123/255, alpha: 1)
        lastMessageFont = UIFont.systemFont(ofSize: 12)
        showName = true
        nameColor = UIColor.black
        nameFont = UIFont.systemFont(ofSize: 16, weight: .heavy)
        showUnreadMessagesCount = true
        unreadMessageCountColor = UIColor.white
        unreadMessageCountFont = UIFont.boldSystemFont(ofSize: 16)
        unreadMessageCountBackgroundColor = UIColor(displayP3Red: 36/255, green: 211/255, blue: 97/255, alpha: 1)
        showProfileIcon = true
        seperatorColor = UIColor.lightText
        showSeperator = true
    }
}
