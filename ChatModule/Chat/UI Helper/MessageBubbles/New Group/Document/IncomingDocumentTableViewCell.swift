//
//  IncomingDocumentTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 27/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class IncomingDocumentTableViewCell: DocumentMsgTableViewCell {

   override func setUIAccToTheme() {
        super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.incoming_bubbleBackGroundColor
        nameLbl.textColor = theme.outgoing_bubbleTextColor
    }
    
}
