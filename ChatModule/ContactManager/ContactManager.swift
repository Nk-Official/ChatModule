//
//  ContactManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 26/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Contacts
struct ContactManager {
    
    
    private let store = CNContactStore()
    
    func saveContactToContacts(contacts: [CNContact]) throws {
        
        if contacts.isEmpty{
            throw CustomError.custom("contact not found")
        } // check array have any object otherwise return
        
        let saveRequest = CNSaveRequest()
        let mutableContacts = contacts.compactMap({ ($0.mutableCopy() as! CNMutableContact) })
        let _ = mutableContacts.map({saveRequest.add($0, toContainerWithIdentifier: nil)})
        
        do{
            try store.execute(saveRequest)
        }
        catch{
            throw error
        }
    
    }
    
}
