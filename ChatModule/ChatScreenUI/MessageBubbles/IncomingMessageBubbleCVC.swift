//
//  IncomingMessageBubbleCVC.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import UIKit

class IncomingMessageBubbleTVC: TextMsgTableViewCell {
    override func setUIAccToTheme() {
        super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.incoming_bubbleBackGroundColor
        msgLbl.textColor = theme.incoming_bubbleTextColor
        timeLbl.textColor = theme.incoming_bubbleTimeLblColor
        
        msgBackgroundView.layer.borderWidth = 1
        msgBackgroundView.layer.borderColor = theme.incoming_bubbleBorderColor.cgColor
    }
}
