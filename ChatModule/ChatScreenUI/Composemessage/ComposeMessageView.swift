//
//  ComposeMessageView.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//


import ContactsUI

protocol ComposeMssageDelegate {
    func textMessageSent(_ composeMessageView: ComposeMessageView, message : String)
    func audioMessageSent(_ composeMessageView: ComposeMessageView, audioUrl : URL)
    func imageMessageSent(_ composeMessageView: ComposeMessageView, images : [UIImage])
//    func messageSent(_ composeMessageView: ComposeMessageView, message : Message)
}

class ComposeMessageView: UIView{
    @IBOutlet weak private var contentV : UIView!
    @IBOutlet weak private var msgTextV : CustomTextView!
    @IBOutlet weak private var msgTextVHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak private var microphnBtn : UIButton!
    @IBOutlet weak private var sendMsgBtn : UIButton!

    
    private let audioRecodermngr = AudioRecorderManager(audioName: "sendVoiceMsg", typeExt: "mpeg")

    
    
    @IBAction private func sendMsgBtn(_ sender : UIButton){
         let message = msgTextV.getText().trimmingCharacters(in: .whitespacesAndNewlines)
        if message.count > 0{
            delegate?.textMessageSent(self, message: message)
            msgTextV.setText(text: "")
        }
    }
    
    @IBAction private func  cameraBtn(_ sender : UIButton){
        
    }
    @IBAction private func  attachMnetBtn(_ sender : UIButton){
        let actionSheetMng = AttachmentActionSheet()
        actionSheetMng.delegate = self
        actionSheetMng.presentActionSheet()
    }
    @IBAction private func  microPhnBtn(_ sender : UIButton){
        if !audioRecodermngr.recordingInProcess{
            audioRecodermngr.startRecording()
        }
        else{
            audioRecodermngr.finishRecording()
        }
    }
    //variables
    var fixedMinHeight: CGFloat = 40
    var delegate : ComposeMssageDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // we need to adjust the frame of the subview to no longer match the size used
        // in the XIB file BUT the actual frame we got assinged from the superview
        self.contentV.frame = self.bounds
    }
    func commonInit(){
        Bundle.main.loadNibNamed("ComposeMessageView", owner: self, options: nil)
        self.addSubview(contentV)
        contentV.frame = self.bounds
        contentV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        msgTextV.editingChanged = {
            (text,_) in
            // trigger your animation here
            self.resizeHeightOfMsgTxvtV(text: text)
        }
        audioRecodermngr.delegate = self
    }
    func resizeHeightOfMsgTxvtV(text : String?){
        let newSize = self.msgTextV.sizeThatFits(CGSize(width: self.msgTextV.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let numberOfLine = self.msgTextV.calculateMaxLines()
        if numberOfLine < 5{
            self.msgTextVHeightConstraint.constant = newSize.height
        }
        let enable = ((text == nil) || (text?.count ?? 0 == 0))
        self.setSendTextMessageBtn(enable: !enable)
    }
    
}
//MARK: - AudioRecorderManagerDelegate
extension  ComposeMessageView : AudioRecorderManagerDelegate{
    func didRecordedAudio(manager: AudioRecorderManager, audioUrl: URL?, error: Error?) {
        print("url",audioUrl as Any)
//        manager.deleteAudio()
        if let url = audioUrl{
            delegate?.audioMessageSent(self, audioUrl: url)
        }
    }
    
    func setSendTextMessageBtn(enable : Bool){
        sendMsgBtn.isHidden = !enable
        microphnBtn.isHidden = enable
    }
}
//MARK: - AttachmentActionSheetDelegate
extension ComposeMessageView: AttachmentActionSheetDelegate{
    func didPickImage(sheet: AttachmentActionSheet, image: UIImage) {
        delegate?.imageMessageSent(self, images: [image])
    }
    
    func didPickVideo(sheet: AttachmentActionSheet, videoUrl: URL) {
        
    }
    
    func didPickDocument(sheet: AttachmentActionSheet, urls: [URL]) {
        
    }
    
    func didPickContacts(sheet: AttachmentActionSheet, contacts: [CNContact]) {
        
    }
}
