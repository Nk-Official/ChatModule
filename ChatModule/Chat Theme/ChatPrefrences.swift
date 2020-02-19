//
//  ChatPrefrences.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
open class ChatPrefrences {
    
    static var shared = ChatPrefrences()
    
    var imageViewerPrefrences: ImageMessagePreviewPrefrences = ImageMessagePreviewPrefrences()
    
    
}
//MARK: - ImageMessagePreviewPrefrences
struct ImageMessagePreviewPrefrences{
    
    var canForward: Bool
    var canMarkFavorite: Bool
}

extension ImageMessagePreviewPrefrences{
    init(){
        canForward = true
        canMarkFavorite = true
    }
}
