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
    @IBOutlet weak var viewController: UIViewController!
    
    //MARK: - UIProperty
    var stackView: UIStackView?
    var textViewHeightConstraint : NSLayoutConstraint?
    var textView: UITextView?
    var addBtn: UIButton?
    var cameraBtn: UIButton?
    var microphoneBtn: UIButton?
    var sendMessageBtn: UIButton?
    
    var audioMessageStackView: UIStackView?
    var audioMesssageImageView: UIImageView?
    var slideToCancelBtn: UIButton?
    var timerLbl: UILabel?
    
    //MARK: - CALLBACKS
    var composeMsgdelegate: ComposeMssageDelegate?
    var locationPickerDelegate: LocationPickerDelegate?
    var uiDelegate: ComposeMssageUIDelegate?
    let actionSheetMng = AttachmentActionSheet()
    private let audioRecodermngr = AudioRecorderManager(audioName: "sendVoiceMsg", typeExt: "mpeg")

    //MARK: - STORED PROPERTY
    lazy var stopWatch: StopWatch = StopWatch()
    var closeAudioMsg: Bool = false
    
    var ifTextMessageAnimateddViewSetUp: Bool{
        return stackView != nil
    }
    var ifAudioMessageAnimateddViewSetUp: Bool{
        return audioMessageStackView != nil
    }
    
    let animationDuration: Double = 0.5
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if stackView == nil{
            makeTextMessageComposerVisible()
        }
    }
    
    //MARK: - UI METHODS
    func setUpComposeTextMessageStackView(){
        
        addBtn = addButton()
        cameraBtn = cameraButton()
        microphoneBtn = microPhoneButton()
        textView = getTextView()
        sendMessageBtn = sendMsgButton()
        audioMesssageImageView = microPhoneImg()
        slideToCancelBtn = slideToCancelButton()
        timerLbl = getTimerLbl()
        
        sendMessageBtn?.isHidden = true
        audioMesssageImageView?.isHidden = true
        slideToCancelBtn?.isHidden = true
        timerLbl?.isHidden = true

//        [addBtn,cameraBtn,microphoneBtn,audioMesssageImageView,sendMessageBtn,slideToCancelBtn,timerLbl].forEach { (btn) in
//            btn?.backgroundColor = .red
//        }
       
        
        let stckView = UIStackView()
        stckView.axis = .horizontal
        stckView.addArrangedSubview(addBtn!)
        stckView.addArrangedSubview(textView!)
        
        stckView.addArrangedSubview(audioMesssageImageView!)
        stckView.addArrangedSubview(audioMesssageImageView!)
        stckView.addArrangedSubview(timerLbl!)

        
        stckView.addArrangedSubview(slideToCancelBtn!)
        stckView.addArrangedSubview(cameraBtn!)
        stckView.addArrangedSubview(microphoneBtn!)
        stckView.spacing = 10
        stckView.alignment = .bottom
        self.stackView = stckView
        stackView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 2.5, right: 0)
        stackView?.isLayoutMarginsRelativeArrangement = true
    }
    
    func makeTextMessageComposerVisible(){
        if !ifTextMessageAnimateddViewSetUp{
            setUpComposeTextMessageStackView()
        }
        items = [UIBarButtonItem(customView: stackView!) ]
    }
      
}

//MARK: - ANIMATION
extension ComposeMessageToolBar{
    
    func openAudioRecorderAnimation(){
        func animate(){
            self.cameraBtn?.alpha = 0
            self.microphoneBtn?.alpha = 0
            self.textView?.alpha = 0
            self.addBtn?.alpha = 0

            self.audioMesssageImageView?.alpha = 1
            self.slideToCancelBtn?.alpha = 1
            self.timerLbl?.alpha = 1

            self.cameraBtn?.isHidden = true
            self.textView?.isHidden = true
            self.addBtn?.isHidden = true

            self.audioMesssageImageView?.isHidden = false
            self.slideToCancelBtn?.isHidden = false
            self.timerLbl?.isHidden = false

            self.addBtn?.transform = CGAffineTransform(translationX: -100, y: 0)
            self.textView?.transform = CGAffineTransform(translationX: -100, y: 0)
        }
        self.audioMesssageImageView?.alpha = 0
        self.slideToCancelBtn?.alpha = 0
        self.timerLbl?.alpha = 0
        UIView.animate(withDuration: animationDuration, animations: {
            animate()
        }) { (_) in
            self.microphoneBtn?.alpha = 1
        }
    }
    func closeAudioRecorderAnimation(){
        func animate(){
            self.cameraBtn?.alpha = 1
            self.microphoneBtn?.alpha = 1
            self.textView?.alpha = 1
            self.addBtn?.alpha = 1

            self.slideToCancelBtn?.alpha = 0
            self.timerLbl?.alpha = 0
            self.audioMesssageImageView?.alpha = 0

            self.cameraBtn?.isHidden = false
            self.textView?.isHidden = false
            self.addBtn?.isHidden = false

            self.audioMesssageImageView?.isHidden = true
            self.slideToCancelBtn?.isHidden = true
            self.timerLbl?.isHidden = true
            
            self.addBtn?.transform = CGAffineTransform.identity
            self.textView?.transform = CGAffineTransform.identity
        }
        UIView.animate(withDuration: animationDuration) {
            animate()
        }

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
        let button = createButton(with: "", Image: UIImage(named: "microphoneBlue"), action: nil)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(
                    target: self,
                    action: #selector(microPhoneTouchesHandle(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.1
        button.addGestureRecognizer(longPressGestureRecognizer)
        return button
    }
    
    func sendMsgButton()->UIButton{
        let button = createButton(with: "", Image: UIImage(named: "sendMessage"), action: #selector(addbtnAction))
        button.backgroundColor = .blue
        return button
    }
    func createButton(with title: String, Image: UIImage?, action: Selector?)->UIButton{
        let button = UIButton()
        button.frame.size.width = 40
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        button.setTitle(title, for: .normal)
        button.setImage(Image, for: .normal)
        if action != nil{
            button.addTarget(self, action: action!, for: .touchUpInside)
        }
        button.setContentHuggingPriority(.required, for: .horizontal)
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
    @objc func microPhoneTouchesHandle(_ gesture: UILongPressGestureRecognizer){
        switch gesture.state{
        case .began: print("began")
            openAudioRecorderAnimation()
            stopWatch.resetTimer()
            stopWatch.startTimer()
            stopWatch.triggerAction = {
                (timeValue) in
                DispatchQueue.main.async {
                    if self.closeAudioMsg{
                        self.showHint()
                        self.stopWatch.stopTimer()
                        self.closeAudioRecorderAnimation()
                        self.closeAudioMsg = false
                    }else{
                        print(timeValue)
                        self.timerLbl?.text = timeValue
                    }
                }
            }
        case .cancelled: print("cancelled")
        case .ended:
            print("ended")
            if stopWatch.hour == 0 && stopWatch.minute == 0 && stopWatch.second == 0{
                
                closeAudioMsg = true
                
            }else{
//                print(stopWatch.hour,stopWatch.minute,stopWatch.second)
            }
            print("ended")
        default:print(gesture.state.rawValue)
        }
    }
    
    @objc func microPhnButtonPress(_ sender: UIButton){
        print("press down")
        self.openAudioRecorderAnimation()
    }
    @objc func microphonebtnRelease(_ sender: UIButton){
        print("press release")
        self.closeAudioRecorderAnimation()
    }
    @objc func sendMsgbtnAction(_ sender: UIButton){
        let message = textView?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if message.count > 0{
            composeMsgdelegate?.textMessageSent(self, message: message)
            textView?.text = ""
        }
    }
}

//MARK: - PRESENTER
extension ComposeMessageToolBar {
    func showHint(){
        let vc = MessagePopOverViewController.initiatefromStoryboard(.main)
        vc.modalPresentationStyle = .popover
        vc.message = "Hold to record, release to send"
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.permittedArrowDirections = .down
        popover.sourceView = viewController.view
        popover.sourceRect = microphoneBtn!.frame
        popover.delegate = viewController as? UIPopoverPresentationControllerDelegate
        popover.barButtonItem = UIBarButtonItem(customView: microphoneBtn!)
        popover.backgroundColor = .blue
        viewController.present(vc, animated: true, completion: nil)
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
