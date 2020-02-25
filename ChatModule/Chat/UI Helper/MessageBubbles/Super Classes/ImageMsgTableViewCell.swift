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
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    @IBAction func imagetap(_ sender: UIButton){
        if imageMsgView.image != nil{
            imageTap?(self,imageMsgView.image!)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var imageTap : ((ImageMsgTableViewCell,UIImage)->())?

    override func configureUI() {
        super.configureUI()
        if message == nil{return}
        indicator.hidesWhenStopped = true
        imageMsgView.setImage(from: message.imageMsg ?? "", startLoading: {
            self.indicator.startAnimating()
        }) {
            self.indicator.stopAnimating()
        }
        timeLbl.text = dateManager.getTime(from: message.sendDateTime)
        msgStateImgV.image = getMessageStateImg()
    }
}
