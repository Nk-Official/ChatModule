//
//  ContactsDataSource.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
//MARK: - ContactsDataSource
protocol ContactsDataSource {
    func contactsList(_ viewController: ContactsViewController, contacts list : @escaping (([Channel])->()))
    func cellForRowAt(_ viewController: ContactsViewController,for user : Channel, at row : Int)->UITableViewCell?
    func startRefreshing(_ viewController: ContactsViewController, completion : @escaping ([Channel])->())
    func currentUser(_ viewController: ContactsViewController, completion : @escaping (Channel)->())
}
