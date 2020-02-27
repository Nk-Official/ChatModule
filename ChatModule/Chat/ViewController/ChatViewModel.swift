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
    var lastIndex : IndexPath?{
        let lastSection = messages.value.count - 1
        if lastSection >= 0 {
            let lastRow = messages.value[lastSection].messages.count-1
            return IndexPath(row: lastRow, section: lastSection)
        }
        return nil
    }
    init(userId: String) {
        self.userId = userId
    }
 
    let incomingTextCell = "incomingcell"
    let incomingAudioCell = "OutgoingAudioMsgBubble"
    let incomingImageCell = "IncomingImageMsgTableViewCell"
    let incomingVideoCell = "OutgoingAudioMsgBubble"
    let incomingFileCell = "IncomingDocumentTableViewCell"
    let incomingLocationCell = "IncomingLocationTableViewCell"
    let incomingContactCell = "IncomingContactTableViewCell"
    
    let outgoingTextCell = "outgoingcell"
    let outgoingAudioCell = "OutgoingAudioMsgBubble"
    let outgoingImageCell = "OutgoingImageMsgTableViewCell"
    let outgoingVideoCell = "OutgoingAudioMsgBubble"
    let outgoingFileCell = "OutGoingDocumentTableViewCell"
    let outgoingLocationCell = "OutgoingLocationTableViewCell"
    let outgoingContactCell = "OutGoingContactTableViewCell"
}
