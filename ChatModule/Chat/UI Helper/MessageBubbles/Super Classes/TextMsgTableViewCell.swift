//
//  TextMsgTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation
import UIKit

class TextMsgTableViewCell : MessageTableViewCell{
    
    @IBOutlet weak   var msgLbl : UILabel!

    override func configureUI(){
        if message == nil{
            msgLbl.text = nil
            timeLbl.text = nil
            msgStateImgV.image = nil
            return
        }
        msgLbl.text = message.message
        timeLbl.text = dateManager.getTime(from: message.sendDateTime)
        msgStateImgV.image = getMessageStateImg()
        
    }
}
