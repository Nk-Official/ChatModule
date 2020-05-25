//
//  ComposeMessageToolBar.swift
//  ChatModule
//
//  Created by user on 18/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
import ContactsUI

class ComposeMessageToolBar : UIToolbar{
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    var messageTextView: UITextView?
    var threasholdOfTextViewHeight: CGFloat = 0
    var composeMsgdelegate: ComposeMssageDelegate?
    var locationPickerDelegate: LocationPickerDelegate?
    var uiDelegate: ComposeMssageUIDelegate?
    let actionSheetMng = AttachmentActionSheet()
    var stackview = UIStackView()
    
    private let audioRecodermngr = AudioRecorderManager(audioName: "sendVoiceMsg", typeExt: "mpeg")

    //MARK: - INHERITANCE
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addButtons()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if messageTextView == nil{return}
        if keyPath == "frame"
        {
            let numberOfLines = getNumberOfLine()
            if numberOfLines <= 5{
                let oldheight = self.heightConstraint.constant
                let newheight = self.messageTextView!.frame.height + 9
                self.heightConstraint.constant = newheight
                uiDelegate?.heightChange(self, from: oldheight, to: newheight)
            }
            
            if numberOfLines == 5{
                threasholdOfTextViewHeight = self.messageTextView!.frame.height
            }
            
        }
        
    }
    
    //MARK: - METHODS
    func addButtons(){
        let addbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFileBtn))
//        messageTextView = getTextView()
//        let textview = UIBarButtonItem(customView: messageTextView!)
//        let cambtn = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addCameraBtn))
//        let audiobtn = UIBarButtonItem(image: UIImage(named: "microphoneBlue") , style: .plain, target: self, action: #selector(mocrophoneBtn))
        
        let stckv = stackView()
        items = [UIBarButtonItem(customView: stckv) ]
        audioRecodermngr.delegate = self

    }
    func stackView()->UIStackView{
                
        let camButton = UIButton()
        camButton.frame.size.width  = 40
        camButton.setImage(UIImage(named: "cameraIcon") , for: .normal)
        camButton.tintColor = .blue
        
        let audioBtn = UIButton()
        audioBtn.frame.size.width  = 40
        audioBtn.setImage(UIImage(named: "microphoneBlue") , for: .normal)
        audioBtn.tintColor = .blue
        
        let textView = UITextView()
        textView.text = "shjgfjgdsjg"
        textView.backgroundColor = .red
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.autocorrectionType = .no
        textView.layer.cornerRadius = 20
        textView.layer.borderColor = UIColor.seperatorColor.cgColor
        textView.layer.borderWidth = 1
        textView.delegate = self
        textView.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        messageTextView = textView
        
        let stackView = UIStackView(frame: frame)
        stackView.axis = .horizontal
//        stackView.alignment = .bottom
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(camButton)
        stackView.addArrangedSubview(audioBtn)
        textView.sizeToFit()
        self.stackview = stackView
        
        return stackView
    }
    
    func getTextView()->UITextView{
        let width = UIScreen.main.bounds.width-3*(45)
        let textView = UITextView(frame: CGRect.zero )
        textView.frame.size.width = width
        textView.layer.cornerRadius = 20
        textView.layer.borderColor = UIColor.seperatorColor.cgColor
        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.autocorrectionType = .no
        textView.delegate = self
        textView.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        return textView
    }
    func resizeHeightOfMsgTxvtV(text : String?){
        if messageTextView == nil{return}
        let numberOfLines = getNumberOfLine()
        if numberOfLines < 5{
//            messageTextView?.frame = CGRect(x: 0, y: 0, width: messageTextView!.frame.width, height: messageTextView!.contentSize.height)
            messageTextView?.frame.size.height = messageTextView!.contentSize.height
        }
        
    }
    
    func getNumberOfLine()->Int{
        if messageTextView == nil{return 0}
        let numberOfLine = self.messageTextView!.calculateMaxLines()
        return numberOfLine
    }
    
    //MARK: - SELECTOR
    @objc func addFileBtn(){
        
        actionSheetMng.delegate = self
        actionSheetMng.locationPickerDelegate = locationPickerDelegate
        actionSheetMng.presentActionSheet()
        
    }
    
    @objc func addCameraBtn(){
        actionSheetMng.presentLibrary()
    }
    
    @objc func mocrophoneBtn(){
        if !audioRecodermngr.recordingInProcess{
            audioRecodermngr.startRecording()
        }
        else{
            audioRecodermngr.finishRecording()
        }
    }
}


//MARK: - UITextViewDelegate
extension ComposeMessageToolBar: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else{return}
        self.resizeHeightOfMsgTxvtV(text: text)
        stackview.arrangedSubviews[1].isHidden = true
    }
    
}

//MARK: - AttachmentActionSheetDelegate
extension ComposeMessageToolBar: AttachmentActionSheetDelegate{
    
    
    func didPickImage(sheet: AttachmentActionSheet, image: UIImage) {
        composeMsgdelegate?.imageMessageSent(self, images: [image])
    }
    
    func didPickVideo(sheet: AttachmentActionSheet, videoUrl: URL) {
        
    }
    
    func didPickDocument(sheet: AttachmentActionSheet, url: URL) {
        print("\n\n\n\n hkjhkjkjlkjlk\n",url,"\n\n\n",url.pathExtension,"\n\n")
        composeMsgdelegate?.fileMessageSent(self, url: url)
    }
    
    func didPickContacts(sheet: AttachmentActionSheet, contacts: [CNContact]) {
        composeMsgdelegate?.contactMessageSent(self, contacts: contacts)
    }
}

//MARK: - AudioRecorderManagerDelegate
extension  ComposeMessageToolBar : AudioRecorderManagerDelegate{
    func didRecordedAudio(manager: AudioRecorderManager, audioUrl: URL?, error: Error?) {
        print("url",audioUrl as Any)
//        manager.deleteAudio()
        if let url = audioUrl{
            composeMsgdelegate?.audioMessageSent(self, audioUrl: url)
        }
    }
    
    func setSendTextMessageBtn(enable : Bool){
//        sendMsgBtn.isHidden = !enable
//        microphnBtn.isHidden = enable
    }
}
