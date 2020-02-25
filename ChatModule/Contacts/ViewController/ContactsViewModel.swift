//
//  ContactsViewModel.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 11/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import RxSwift
import RxCocoa
class ContactsViewModel {
    
    
    //MARK: - VARIABLES
    let firebaseManager : FireBaseManager
    let contacts : BehaviorRelay<[Channel]> = BehaviorRelay(value: [])
       //MARK: - INIT
    init() {
        firebaseManager =  FireBaseManager()
    }
        
       //MARK: - NETWORK CALL
//    func fetchContacts(){
//        firebaseManager.getAllUsers { (users) in
//            self.contacts.accept(users)
//        }
//    }
    
}
