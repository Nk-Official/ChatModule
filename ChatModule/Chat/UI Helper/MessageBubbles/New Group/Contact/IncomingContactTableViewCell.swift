//
//  IncomingContactTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 27/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class IncomingContactTableViewCell: ContactMsgTableViewCell {

    override func setUIAccToTheme() {
        super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.incoming_bubbleBackGroundColor
        nameLbl.textColor = theme.incoming_bubbleTextColor
        profileImgView.cornerRadius = profileImgView.frame.width/2
        profileImgView.clipsToBounds = true
    }
}
