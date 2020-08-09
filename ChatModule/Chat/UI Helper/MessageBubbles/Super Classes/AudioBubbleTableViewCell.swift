//
//  AudioBubbleTVC.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//
import RxSwift
import RxCocoa
class AudioBubbleTableViewCell : MessageTableViewCell{
   
    //MARK: - PROPERTIES
    private var playing : BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var playerManager : AudioPlayerManager?
    let disposeBag = DisposeBag()
    
    //MARK: - OUTLETS
    @IBOutlet weak   var progressBar : UISlider!
    @IBOutlet weak   var playpausetapImgV : UIImageView!
    @IBOutlet weak   var avatarImgV : UIImageView!
   
    //MARK: - ACTIONS
    @IBAction func playPause(_ sender: UIButton){
        playing.accept(!playing.value)
    }
    
    override func configureUI(){
        super.configureUI()
        if message == nil{
            timeLbl.text = nil
            msgStateImgV.image = nil
            return
        }
        
        playerManager = AudioPlayerManager(url: URL(string: message.audioMsg!)! )
        playerManager?.delegate = self
        timeLbl.text = message.sendDateTime
        msgStateImgV.image = getMessageStateImg()
        binding()
    }
    
    func binding(){
        let playingImg = UIImage(named: "playAudio")
        let pauseImg = UIImage(named: "pauseAudio")
        playing.subscribe { (event) in
            switch event{
            case .next(let value):
                value ?  self.play()  : self.stop()
                self.playpausetapImgV.image = value ? pauseImg : playingImg
            default:break
            }
        }.disposed(by: disposeBag)
    }
    
    
    
    //MARK: - DELEGATES
    func play(){
        playerManager?.playAudio()
    }
    func stop(){
        playerManager?.stopAudio()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        playerManager?.stopAudio()
        playerManager = nil
    }
}
//MARK: - AudioPlayerManagerDelegate
extension AudioBubbleTableViewCell: AudioPlayerManagerDelegate{
    func didFinishPlayingAudio(_ audioPlayerManager: AudioPlayerManager, url: URL) {
        playing.accept(false)
    }
}
