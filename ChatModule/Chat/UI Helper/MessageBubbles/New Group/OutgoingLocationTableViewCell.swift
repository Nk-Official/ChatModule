//
//  OutgoingLocationTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class OutgoingLocationTableViewCell: LocationMsgTavleViewCell {

    override func setUIAccToTheme() {
        super.setUIAccToTheme()
        msgBackgroundView.backgroundColor = theme.outgoing_bubbleBackGroundColor
        timeLbl.textColor = UIColor.white
    }
    
}
