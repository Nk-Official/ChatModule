//
//  DummyViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import UIKit

class DummyViewController: UIViewController , UITextFieldDelegate{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
           view.becomeFirstResponder()

    }
    
    let audiomng = AudioRecorderManager(audioName: "recording", typeExt: "mpeg")
    @IBAction func record(_ sender: UIButton){
//        UIPopoverPresentationController(presentedViewController: <#T##UIViewController#>, presenting: <#T##UIViewController?#>)
//        audiomng.startRecording()

        
        let vc = MenuPopOverViewController.initiatefromStoryboard(.main)
        vc.modalPresentationStyle = .popover
        let popoverc = vc.popoverPresentationController
        popoverc?.delegate = self
        popoverc?.barButtonItem = UIBarButtonItem(customView: sender)
        popoverc?.backgroundColor = UIColor.red
        
        present(vc, animated: true, completion: nil)
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



extension DummyViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
//    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
//        return .popover
//    }
    
}
