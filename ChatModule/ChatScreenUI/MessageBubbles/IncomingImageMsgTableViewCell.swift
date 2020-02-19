//
//  IncomingImageMsgTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class IncomingImageMsgTableViewCell: ImageMsgTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    override func setUIAccToTheme() {
        super.setUIAccToTheme()
        
        msgBackgroundView.backgroundColor = theme.incoming_bubbleBackGroundColor
        timeLbl.textColor = UIColor.white
    }
    
}
