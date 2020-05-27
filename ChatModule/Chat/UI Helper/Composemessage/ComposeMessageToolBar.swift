//
//  ComposeMessageToolBarView.swift
//  ChatModule
//
//  Created by user on 26/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
import ContactsUI

class ComposeMessageToolBar: UIToolbar{
    
    @IBOutlet weak var bottomToolbarHeight: NSLayoutConstraint!

    var stackView: UIStackView?
    var textViewHeightConstraint : NSLayoutConstraint?
    var textView: UITextView?
    var addBtn: UIButton?
    var cameraBtn: UIButton?
    var microphoneBtn: UIButton?
    var sendMessageBtn: UIButton?
    
    
    var composeMsgdelegate: ComposeMssageDelegate?
    var locationPickerDelegate: LocationPickerDelegate?
    var uiDelegate: ComposeMssageUIDelegate?
    let actionSheetMng = AttachmentActionSheet()
    private let audioRecodermngr = AudioRecorderManager(audioName: "sendVoiceMsg", typeExt: "mpeg")

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if stackView == nil{
            setUpToolBar()
        }
    }
    
    func setUpToolBar(){
        
        addBtn = addButton()
        cameraBtn = cameraButton()
        microphoneBtn = microPhoneButton()
        textView = getTextView()
        sendMessageBtn = sendMsgButton()
        sendMessageBtn?.isHidden = true
        
        let stckView = UIStackView()
        stckView.axis = .horizontal
        stckView.addArrangedSubview(addBtn!)
        stckView.addArrangedSubview(textView!)
        stckView.addArrangedSubview(sendMessageBtn!)
        stckView.addArrangedSubview(cameraBtn!)
        stckView.addArrangedSubview(microphoneBtn!)
        stckView.spacing = 10
        stckView.alignment = .bottom
        self.stackView = stckView
        stackView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 2.5, right: 0)
        stackView?.isLayoutMarginsRelativeArrangement = true
        items = [UIBarButtonItem(customView: stckView) ]
    }
    
}
//MARK: - BUTTONS
extension ComposeMessageToolBar{
    
    func addButton()->UIButton{
        let addButton = createButton(with: "", Image: UIImage(named: "addBlue"), action: #selector(addbtnAction))
        return addButton
    }
    func cameraButton()->UIButton{
        let addButton = createButton(with: "", Image: UIImage(named: "cameraIcon"), action: #selector(camerabtnAction))
        return addButton
    }
    func microPhoneButton()->UIButton{
        let addButton = createButton(with: "", Image: UIImage(named: "microphoneBlue"), action: #selector(microphonebtnAction))
        return addButton
    }
    func sendMsgButton()->UIButton{
        let addButton = createButton(with: "", Image: UIImage(named: "sendMessage"), action: #selector(addbtnAction))
        addButton.backgroundColor = .blue
        return addButton
    }
    func createButton(with title: String, Image: UIImage?, action: Selector)->UIButton{
        let button = UIButton()
        button.frame.size.width = 40
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        button.setTitle(title, for: .normal)
        button.setImage(Image, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    func getTextView()->UITextView{
        
        let textView = UITextView()
        textView.delegate = self
        textViewHeightConstraint = NSLayoutConstraint(item: textView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 39)
        textView.addConstraint(textViewHeightConstraint!)
        textView.layer.cornerRadius = 20
        textView.layer.borderColor = UIColor.seperatorColor.cgColor
        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.autocorrectionType = .no
        return textView
    }
    
}

//MARK: - SELECTOR
extension ComposeMessageToolBar {
    
    @objc func addbtnAction(_ sender: UIButton){
        actionSheetMng.delegate = self
        actionSheetMng.locationPickerDelegate = locationPickerDelegate
        actionSheetMng.presentActionSheet()
    }
    @objc func camerabtnAction(_ sender: UIButton){
        actionSheetMng.presentCamera()
    }
    @objc func microphonebtnAction(_ sender: UIButton){
        if !audioRecodermngr.recordingInProcess{
            audioRecodermngr.startRecording()
        }
        else{
            audioRecodermngr.finishRecording()
        }
    }
    @objc func sendMsgbtnAction(_ sender: UIButton){
        let message = textView?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if message.count > 0{
            composeMsgdelegate?.textMessageSent(self, message: message)
            textView?.text = ""
        }
    }
}

//MARK: - UITextViewDelegate
extension ComposeMessageToolBar : UITextViewDelegate{
    
    
    func textViewDidChange(_ textView: UITextView) {
        let numberOfLines = textView.calculateMaxLines()
        if numberOfLines == 1{
            textViewHeightConstraint?.constant = 39
        }else if numberOfLines <= 5{
            textViewHeightConstraint?.constant = textView.contentSize.height
        }
        
        bottomToolbarHeight.constant = (textViewHeightConstraint?.constant ?? 0) + 10
        
        guard let messageTyped = textView.text, messageTyped.count > 0 else{
            
            self.microphoneBtn?.isHidden = false
            self.cameraBtn?.isHidden = false
            self.sendMessageBtn?.isHidden = true
            return
        }
        [self.cameraBtn,self.microphoneBtn].forEach { (button) in
            button?.isHidden = true
        }
        self.sendMessageBtn?.isHidden = false
        
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
