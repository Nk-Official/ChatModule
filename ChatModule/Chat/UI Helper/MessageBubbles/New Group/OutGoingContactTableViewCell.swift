//
//  OutGoingContactTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 25/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class OutGoingContactTableViewCell: ContactMsgTableViewCell {

    override func setUIAccToTheme() {
        super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.outgoing_bubbleBackGroundColor
        nameLbl.textColor = theme.outgoing_bubbleTextColor
        profileImgView.cornerRadius = profileImgView.frame.width/2
        profileImgView.clipsToBounds = true
    }
}
