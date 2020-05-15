//
//  ContactInfoViewModel.swift
//  ChatModule
//
//  Created by user on 14/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
class ContactInfoViewModel {
    
    
    func getMediaData()->[ContactInfoTableData]{
        
        let media = ContactInfoTableData(title: "Media, Links and Docs", subtitle: nil, diclusreTitle: "None", typeImage: UIImage(named: "mediaContactInfo")! )
        let starredMsg = ContactInfoTableData(title: "Starred Messages", subtitle: nil, diclusreTitle: "None", typeImage: UIImage(named: "starredMessages")! )
        let chatSearch = ContactInfoTableData(title: "ChatSearch", subtitle: nil, diclusreTitle: nil, typeImage: UIImage(named: "chatSearch")! )

        return [media,starredMsg,chatSearch]
    }
    func contactCustomiseData()->[ContactInfoTableData]{
        
        let mute = ContactInfoTableData(title: "Mute", subtitle: nil, diclusreTitle: "No", typeImage: UIImage(named: "mediaContactInfo")! )
        let customTone = ContactInfoTableData(title: "Custom Tone", subtitle: nil, diclusreTitle: "Default", typeImage: UIImage(named: "starredMessages")! )
        let saveToCameraRoll = ContactInfoTableData(title: "Save to Camera Roll", subtitle: nil, diclusreTitle: "Default", typeImage: UIImage(named: "chatSearch")! )
        let encryption = ContactInfoTableData(title: "Encryption", subtitle: "Message to this chat and calls are secured with end-to-end encryption. Tap to verify.", diclusreTitle: nil, typeImage: UIImage(named: "chatSearch")! )

        return [mute,customTone,saveToCameraRoll,encryption]
    }
}
