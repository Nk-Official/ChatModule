//
//  AudioRecorderManger.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
// https://medium.com/@vikaskore/record-audio-in-ios-swift-4-2-a6a4d53e31b0

import Foundation
import AVKit
protocol AudioRecorderManagerDelegate {
    func didRecordedAudio(manager: AudioRecorderManager,audioUrl: URL?, error : Error?)
}
class AudioRecorderManager : NSObject{
    
    // to start recording session
    var recordingSession = AVAudioSession()
    //recorder instance
    var audioRecorder : AVAudioRecorder!
    //play recorded audio
    var audioPlayer : AVAudioPlayer!
    // document directory
    let docdirectryMng = DocumentDirectoryManager()
    private var audioName : String
    private var typeExt: String
    
    var recordingInProcess : Bool = false
    var delegate : AudioRecorderManagerDelegate?
    
    
    init(audioName:String,typeExt:String) {
        self.audioName = audioName
        self.typeExt = typeExt
        super.init()
        self.setUpAudioRecoder()
    }
    func setUpAudioRecoder(){
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() {  allowed in
                DispatchQueue.main.async {
                    if allowed {
                        
                    } else {
                        // failed to record
                        print("fail to record audio")
                    }}}
        } catch(let err) {
            print("fail to record audio",err.localizedDescription)
        }
    }
    
    func startRecording() {
        let audioFilename = docdirectryMng.getFileURL(name: audioName, typeExtension: typeExt)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordingInProcess = true
        } catch {
            finishRecording()
        }
    }
    func finishRecording() {
        audioRecorder.stop()
        audioRecorder = nil
        recordingInProcess = false
    }
    
    
    func deleteAudio(){        
        docdirectryMng.deleteFileFromDirectory(name: audioName, typeExtension: typeExt)
    }
}
extension AudioRecorderManager:AVAudioRecorderDelegate,AVAudioPlayerDelegate{
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            let urlwhereSaved = docdirectryMng.getFileURL(name: audioName, typeExtension: typeExt) as URL
            delegate?.didRecordedAudio(manager: self, audioUrl: urlwhereSaved, error: nil)
        }
        else{
            deleteAudio()
            delegate?.didRecordedAudio(manager: self, audioUrl: nil, error: nil)
        }
        
    }
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        finishRecording()
//        deleteAudio()
        delegate?.didRecordedAudio(manager: self, audioUrl: nil, error: error)
    }
}
