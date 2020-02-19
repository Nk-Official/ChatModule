//
//  DummyViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import UIKit

class DummyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let audiomng = AudioRecorderManager(audioName: "recording", typeExt: "mpeg")
    @IBAction func record(){
        audiomng.startRecording()
    }
    @IBAction func play(_ sender: UIButton){
//        audiomng.playAudio()
    }
    @IBAction func delete(){
        audiomng.deleteAudio()
    }
    @IBAction func stopRecording(){
        audiomng.finishRecording()
    }
}
