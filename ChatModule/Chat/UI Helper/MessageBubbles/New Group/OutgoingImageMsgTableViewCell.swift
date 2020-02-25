//
//  OutgoingImageMsgTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class OutgoingImageMsgTableViewCell: ImageMsgTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setUIAccToTheme() {
        super.setUIAccToTheme()
        
        msgBackgroundView.backgroundColor = theme.outgoing_bubbleBackGroundColor
        timeLbl.textColor = UIColor.white
    }
}
