//
//  ImageMsgTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class ImageMsgTableViewCell: MessageTableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var imageMsgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    override func configureUI() {
        super.configureUI()
        if message == nil{return}
        imageMsgView.setImage(from: message.imageMsg ?? "")
        timeLbl.text = dateManager.getTime(from: message.sendDateTime)
        msgStateImgV.image = getMessageStateImg()
    }
}
