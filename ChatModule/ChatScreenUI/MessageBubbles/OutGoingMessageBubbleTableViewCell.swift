//
//  OutGoingMessageBubbleTVC.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

class OutGoingMessageBubbleTableViewCell: TextMsgTableViewCell {
    
    override func setUIAccToTheme() {
       super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.outgoing_bubbleBackGroundColor
        msgLbl.textColor = theme.outgoing_bubbleTextColor
        timeLbl.textColor = theme.outgoing_bubbleTimeLblColor
        
        msgBackgroundView.layer.borderWidth = 1
        msgBackgroundView.layer.borderColor = theme.outgoing_bubbleBorderColor.cgColor
    }
}
