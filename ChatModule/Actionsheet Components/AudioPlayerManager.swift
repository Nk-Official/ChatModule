//
//  AudioPlayerManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation

import AVKit

protocol AudioPlayerManagerDelegate {
    func didFinishPlayingAudio(_ audioPlayerManager: AudioPlayerManager, url: URL)
}


class AudioPlayerManager : NSObject{
    
    ///he AVAudioPlayer class does not provide support for streaming audio based on HTTP URL's. The URL used with initWithContentsOfURL: must be a File URL (file://). That is, a local path.
    //play recorded audio
    var audioPlayer : AVPlayer?
    private var urlToPlay : URL
    var delegate : AudioPlayerManagerDelegate?
    
    
    init(url : URL){
        self.urlToPlay = url
        super.init()
    }
    func setUrlToPlay(url : URL){
        self.urlToPlay = url
    }
    
    private func preparePlayer() {
        let playerItem = AVPlayerItem(url: urlToPlay)
        audioPlayer = AVPlayer(playerItem: playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        audioPlayer!.volume = 10.0
    }
    
    func playAudio(){
        preparePlayer()
        audioPlayer?.play()
    }
    func stopAudio(){
        audioPlayer?.pause()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        delegate?.didFinishPlayingAudio(self, url: urlToPlay)
    }
}



