//
//  ContactsDelegate.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation

//MARK: - ContactsDelegate
protocol ContactsDelegate {
    func createGroup(_ viewController: ContactsViewController, group channel : Channel)
    func didSelectContact(_ viewController: ContactsViewController, contact : Channel)
    
}
