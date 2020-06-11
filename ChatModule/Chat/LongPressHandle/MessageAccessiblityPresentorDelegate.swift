//
//  MessageAccessiblityPresentorDelegate.swift
//  ChatModule
//
//  Created by user on 11/06/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

protocol MessageAccessiblityPresentorDelegate {
    
    func starItemSelected(_ presentor: MessageAccessiblityPresentor )
    func replyItemSelected(_ presentor: MessageAccessiblityPresentor )
    func forwardItemSelected(_ presentor: MessageAccessiblityPresentor )
    func copyItemSelected(_ presentor: MessageAccessiblityPresentor )
    func infoItemSelected(_ presentor: MessageAccessiblityPresentor )
    func deleteItemSelected(_ presentor: MessageAccessiblityPresentor )

}
