//
//  IncomingMessageBubbleTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//


class IncomingMessageBubbleTableViewCell: TextMsgTableViewCell {
    override func setUIAccToTheme() {
        super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.incoming_bubbleBackGroundColor
        msgLbl.textColor = theme.incoming_bubbleTextColor
        timeLbl.textColor = theme.incoming_bubbleTimeLblColor
        
        msgBackgroundView.layer.borderWidth = 1
        msgBackgroundView.layer.borderColor = theme.incoming_bubbleBorderColor.cgColor
    }
}
