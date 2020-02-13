//
//  OutGoingMessageBubbleCVC.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import UIKit

class OutGoingMessageBubbleTVC: TextMsgTableViewCell {
    
    override func setUIAccToTheme() {
       super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.outgoing_bubbleBackGroundColor
        msgLbl.textColor = theme.outgoing_bubbleTextColor
        timeLbl.textColor = theme.outgoing_bubbleTimeLblColor
        
        msgBackgroundView.layer.borderWidth = 1
        msgBackgroundView.layer.borderColor = theme.outgoing_bubbleBorderColor.cgColor
    }
}
