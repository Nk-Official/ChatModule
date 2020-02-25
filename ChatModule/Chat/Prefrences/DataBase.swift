//
//  DataBase.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation

struct DBManager{
    let db = UserDefaults.standard
    var chatTheme : ChatTheme{
        
        if let savedTheme = ChatTheme(rawValue: getChatThemeFromUserDefaults()){
            return savedTheme
        }
        return ChatTheme.defaultTheme
        
    }
    
    func saveChatTheme(theme : ChatTheme){
        db.set(theme.rawValue, forKey: UserDefaultsKeys.chatTheme.rawValue)
    }
    private func getChatThemeFromUserDefaults()->String{
        return db.value(forKey: UserDefaultsKeys.chatTheme.rawValue) as? String ?? ""
    }
}

