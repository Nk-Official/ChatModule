//
//  OutGoingDocumentTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 26/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class OutGoingDocumentTableViewCell: DocumentMsgTableViewCell {

   override func setUIAccToTheme() {
        super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.outgoing_bubbleBackGroundColor
        nameLbl.textColor = theme.outgoing_bubbleTextColor
    }
    
}
