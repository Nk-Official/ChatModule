//
//  AudioBubbleTVC.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation
import UIKit
class AudioBubbleTVC : MessageTableViewCell{
   
    
   
    private var playing : Bool = false

    @IBOutlet weak   var progressBar : UISlider!
    @IBOutlet weak   var playpausetapImgV : UIImageView!
    @IBOutlet weak   var avatarImgV : UIImageView!
    
    
    override func configureUI(){
//        super.configureUI()
//        addTapGToImgV()
//        if message == nil{
//            timeLbl.text = nil
//            msgStateImgV.image = nil
//            return
//        }
//        timeLbl.text = message.sendTime
//        msgStateImgV.image = getMessageStateImg()
        
    }
    func addTapGToImgV(){
        let tg = UITapGestureRecognizer(target: self, action: #selector(playPause(_:)))
        playpausetapImgV.isUserInteractionEnabled = true
        playpausetapImgV.addGestureRecognizer(tg)
    }
    @objc func playPause(_ sender: UIGestureRecognizer){
        let playingImg = UIImage(named: "playAudio")
        let pauseImg = UIImage(named: "pauseAudio")
        
        msgStateImgV.image = playing ? pauseImg : playingImg
    }
}
