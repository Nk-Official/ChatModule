//
//  DocumentMsgTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 26/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class DocumentMsgTableViewCell: MessageTableViewCell{
    
    //MARK: - OUTLET
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var fileIconImgView : UIImageView!
    
    var docsdata : Data?
    
    override func configureUI() {
        super.configureUI()
        
        if message == nil{
            nameLbl.text = "-----"
            fileIconImgView.image = UIImage(named: "placeholderUserImg")
            return
        }
        timeLbl.text = dateManager.getTime(from: message.sendDateTime)
        msgStateImgV.image = getMessageStateImg()
        fileIconImgView.image = UIImage(named: "docs")
        guard let fileUrl = message.file else {
            return
        }
        nameLbl.text = URL(string: fileUrl)?.lastPathComponent
        fetchDataFromURL(url: fileUrl) { (data) in
            self.docsdata = data
        }
    }
}
