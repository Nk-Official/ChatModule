//
//  ImageMsgTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//


class ImageMsgTableViewCell: MessageTableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var imageMsgView : UIImageView!
    @IBAction func imagetap(_ sender: UIButton){
        if imageMsgView.image != nil{
            imageTap?(self,imageMsgView.image!)
        }
    }
    
    var imageTap : ((ImageMsgTableViewCell,UIImage)->())?

    override func configureUI() {
        super.configureUI()
        if message == nil{return}
        imageMsgView.setImage(from: message.imageMsg ?? "")
        timeLbl.text = dateManager.getTime(from: message.sendDateTime)
        msgStateImgV.image = getMessageStateImg()
    }
}
