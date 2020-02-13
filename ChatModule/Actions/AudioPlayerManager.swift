//
//  AudioPlayerManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation

import AVKit

class AudioPlayerManager : NSObject{
    
    //play recorded audio
    var audioPlayer : AVAudioPlayer!
    private var urlToPlay : URL
    // document directory
//    private let docdirectryMng = DocumentDirectoryManager()
    
    init(url : URL){
        self.urlToPlay = url
        super.init()
    }
    func setUrlToPlay(url : URL){
        self.urlToPlay = url
    }
    
    private func preparePlayer() {
        var error: NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: urlToPlay)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        if let err = error {
            print("AVAudioPlayer error: \(err.localizedDescription)")
        }
        else {
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 10.0
        }
    }
    
    func playAudio(){
        preparePlayer()
        audioPlayer.play()
    }
    func stopAudio(){
        audioPlayer.stop()
    }
}
extension AudioPlayerManager :  AVAudioPlayerDelegate{
    
}
