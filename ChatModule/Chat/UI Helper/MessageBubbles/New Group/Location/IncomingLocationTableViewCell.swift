//
//  IncomingLocationTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 25/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class IncomingLocationTableViewCell: LocationMsgTavleViewCell {

    override func setUIAccToTheme() {
       super.setUIAccToTheme()
       msgBackgroundView.backgroundColor = theme.incoming_bubbleBackGroundColor
       timeLbl.textColor = UIColor.white
    }
    
}
