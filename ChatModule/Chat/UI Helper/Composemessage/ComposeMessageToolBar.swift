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
    var microPhnContainer: UIView?
    var microPhnImageView: UIImageView?
    var slideToCancelBtn: UIButton?
    var timerLbl: UILabel?
    var lockview: LockAudioMessageView?



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
    let height: CGFloat = 49
    var updatedHeight: CGFloat = 49
    let timerLblWidth: CGFloat = 50
    let lockviewHeight: CGFloat = 140
    let lockviewWidth: CGFloat = 60

    var intialMicroPhnBtnLocation: CGPoint = .zero
    //MARK: - Closure callback
    
    var heightChange: ((CGFloat)->())? // callback is change in height
    
    
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
        (microPhnContainer,microPhnImageView) = microPhoneImg()
        slideToCancelBtn = slideToCancelButton()
        timerLbl = getTimerLbl()
        
        sendMessageBtn?.isHidden = true
//        microPhnImageView?.isHidden = true
        slideToCancelBtn?.isHidden = true
        timerLbl?.isHidden = true
        microPhnContainer?.isHidden = true
//        [addBtn,cameraBtn,microphoneBtn,microPhnImageView,sendMessageBtn,slideToCancelBtn,timerLbl].forEach { (btn) in
//            btn?.backgroundColor = .red
//        }
       
        
        let stckView = UIStackView()
        stckView.axis = .horizontal
        
        stckView.addArrangedSubview(sendMessageBtn!)
        stckView.addArrangedSubview(microphoneBtn!)
        stckView.addArrangedSubview(cameraBtn!)
        stckView.addArrangedSubview(slideToCancelBtn!)

        stckView.addArrangedSubview(timerLbl!)
        stckView.addArrangedSubview(microPhnContainer!)
//        stckView.addArrangedSubview(microPhnImageView!)

        stckView.addArrangedSubview(textView!)
        stckView.addArrangedSubview(addBtn!)
        
        stckView.spacing = 10
        stckView.alignment = .bottom
        stckView.semanticContentAttribute = .forceRightToLeft
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

            self.microPhnContainer?.alpha = 1
            self.slideToCancelBtn?.alpha = 1
            self.timerLbl?.alpha = 1

            self.cameraBtn?.isHidden = true
            self.textView?.isHidden = true
            self.addBtn?.isHidden = true

            self.microPhnContainer?.isHidden = false
            self.slideToCancelBtn?.isHidden = false
            self.timerLbl?.isHidden = false

            self.addBtn?.transform = CGAffineTransform(translationX: -100, y: 0)
            self.textView?.transform = CGAffineTransform(translationX: -100, y: 0)
        }
        stackView?.alignment = .center
        self.microPhnContainer?.alpha = 0
        self.slideToCancelBtn?.alpha = 0
        self.timerLbl?.alpha = 0
        UIView.animate(withDuration: animationDuration, animations: {
            animate()
        }) { (_) in
            self.microphoneBtn?.alpha = 1
        }
    }
    func closeAudioRecorderAnimation(completion: Closure? = nil){
        func animate(){
            self.cameraBtn?.alpha = 1
            self.microphoneBtn?.alpha = 1
            self.textView?.alpha = 1
            self.addBtn?.alpha = 1

            self.slideToCancelBtn?.alpha = 0
            self.timerLbl?.alpha = 0
            self.microPhnContainer?.alpha = 0

            self.cameraBtn?.isHidden = false
            self.textView?.isHidden = false
            self.addBtn?.isHidden = false

            self.microPhnContainer?.isHidden = true
            self.slideToCancelBtn?.isHidden = true
            self.timerLbl?.isHidden = true
            
            self.addBtn?.transform = CGAffineTransform.identity
            self.textView?.transform = CGAffineTransform.identity
        }
        stackView?.alignment = .bottom
        UIView.animate(withDuration: animationDuration, animations: {
            animate()
        }) { (_) in
            completion?()
        }
    }
    
    func closeTheAudioMsg(){
        self.stopWatch.stopTimer()
        if self.stopWatch.isStopWatchAtZero(){
             self.closeAudioRecorderAnimation()
        }else{
           self.throwMicrophnInSky()
        }
        stopWatch.resetTimer()
        self.timerLbl?.text = ""
        closeLockView()

    }
    
    func moveSwipeToClose(with gesture: UIGestureRecognizer){
        let nextLocation = gesture.location(in: self)
        let differenceInLocation = intialMicroPhnBtnLocation.x - nextLocation.x
        if differenceInLocation >= 0{
            if differenceInLocation>130{
                closeTheAudioMsg()
                gesture.state = .cancelled
                slideToCancelBtn?.transform = .identity
                return
            }
            slideToCancelBtn?.transform = CGAffineTransform(translationX: -differenceInLocation, y: 0)
            slideToCancelBtn?.alpha = 1-(differenceInLocation/(timerLblWidth+10))
        }
    }
    func blinkMicropPhoneImage(){
        
        UIView.animate(withDuration: 0.5, animations: {
            self.microPhnImageView?.image =  UIImage(named: "microphoneFilledRed")
            self.microPhnImageView?.alpha = 0
        }) { (_) in
            UIView.animate(withDuration: 0.5) {
                self.microPhnImageView?.alpha = 1
            }
            
        }
        
    }
    func throwMicrophnInSky(){
        
        let dustbin = UIImageView(frame: microPhnContainer!.bounds)
        dustbin.image = UIImage(named: "trashBin")
        dustbin.isHidden = true
        microPhnContainer?.addSubview(dustbin)
        let duration  = animationDuration
        
        slideToCancelBtn?.alpha = 0
        timerLbl?.alpha = 0
        
        UIView.animate(withDuration: duration, animations: {
            self.microPhnImageView?.transform = CGAffineTransform(translationX: 0, y: -180)
        }) { (_) in
            UIView.animate(withDuration: duration, animations: {
                dustbin.isHidden = false
                self.microPhnImageView?.transform = CGAffineTransform(rotationAngle: .pi)
            }) { (_) in
                UIView.animate(withDuration: duration, animations: {
                    self.microPhnContainer!.transform = CGAffineTransform(translationX: 0, y: 180)
                }) { (_) in
                    self.closeAudioRecorderAnimation {
                        self.microPhnContainer!.transform = .identity
                        self.microPhnImageView?.transform = .identity
                        dustbin.removeFromSuperview()
                    }
                }
            }
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
        let button = createButton(with: "", Image: UIImage(named: "sendMessage"), action: #selector(sendMsgbtnAction))
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
        textViewHeightConstraint = NSLayoutConstraint(item: textView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height-10)
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
        case .began:
            intialMicroPhnBtnLocation = gesture.location(in: self)
            
            openAudioRecorderAnimation()
            stopWatch.resetTimer()
            stopWatch.startTimer()
            self.closeAudioMsg = false
            stopWatch.triggerAction = {
                (timeValue) in
                DispatchQueue.main.async {
                    if self.closeAudioMsg{
                        self.closeTheAudioMsg()
                    }else{
                        if self.stopWatch.second > 1{
                            self.showLockView()
                        }
                        self.blinkMicropPhoneImage()
                        self.timerLbl?.text = timeValue
                    }
                }
            }
        case .changed: moveSwipeToClose(with: gesture)
        case .cancelled:break
        case .ended:
            if stopWatch.isStopWatchAtZero(){
                self.stopWatch.triggerAction = nil
                self.showHint()
                self.closeTheAudioMsg()
            }
            closeAudioMsg = true
            intialMicroPhnBtnLocation = .zero
            slideToCancelBtn?.transform = .identity
        default:break
        }
    }
    
    
    @objc func sendMsgbtnAction(_ sender: UIButton){
        let message = textView?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if message.count > 0{
            composeMsgdelegate?.textMessageSent(self, message: message)
            textView?.text = nil
            textViewDidChange(textView!)
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
        popover.backgroundColor = UIColor(0x1478F6)
        viewController.present(vc, animated: true, completion: nil)
    }
    func showLockView(){
        if lockview != nil{return}
//        let superview = viewController.view
        lockview = LockAudioMessageView()
        lockview?.translatesAutoresizingMaskIntoConstraints = false
        superview!.insertSubview(lockview!, belowSubview: self)

        let margins = superview!.layoutMarginsGuide

        lockview!.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -height-1).isActive = true
        lockview!.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 20).isActive = true
        
        let width = NSLayoutConstraint(item: lockview!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: lockviewWidth)
        let height = NSLayoutConstraint(item: lockview!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: lockviewHeight)
        width.isActive = true
        height.isActive = true
        lockview!.addConstraints([width,height])
    }
    func openLockViewWithAnimation(){
        
    }
    func closeLockView(){
        if lockview == nil{return}
        
        UIView.animate(withDuration: 0.2, animations: {
            self.lockview?.transform = CGAffineTransform(translationX: 0, y: self.lockviewHeight)
        }) { (_) in
            self.lockview?.removeFromSuperview()
            self.lockview = nil
        }
    }
}

//MARK: - UITextViewDelegate
extension ComposeMessageToolBar : UITextViewDelegate{
    
    
    func textViewDidChange(_ textView: UITextView) {
        let numberOfLines = textView.calculateMaxLines()
        if numberOfLines == 1{
            textViewHeightConstraint?.constant = height-10
        }else if numberOfLines <= 5{
            textViewHeightConstraint?.constant = textView.contentSize.height
        }
        
        let previousHeight =  bottomToolbarHeight.constant
        bottomToolbarHeight.constant = (textViewHeightConstraint?.constant ?? 0) + 10

        let newHeight =  bottomToolbarHeight.constant

        if newHeight != previousHeight{
            let change = (bottomToolbarHeight.constant - height)
            heightChange?(change)
        }
        

        
        guard let messageTyped = textView.text, messageTyped.count > 0 else{
            
            UIView.animate(withDuration: 0.2, animations: {
                self.microphoneBtn?.isHidden = false
                self.cameraBtn?.isHidden = false
                self.sendMessageBtn?.isHidden = true
            }) { (_) in
                self.microphoneBtn?.isHidden = false
                self.cameraBtn?.isHidden = false
                self.sendMessageBtn?.isHidden = true
            }
            return
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.microphoneBtn?.isHidden = true
            self.cameraBtn?.isHidden = true
            self.sendMessageBtn?.isHidden = false
        }) { (_) in
            self.microphoneBtn?.isHidden = true
            self.cameraBtn?.isHidden = true
            self.sendMessageBtn?.isHidden = false
        }
        
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
