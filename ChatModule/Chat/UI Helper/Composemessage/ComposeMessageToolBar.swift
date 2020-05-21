//
//  ComposeMessageToolBar.swift
//  ChatModule
//
//  Created by user on 18/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
class ComposeMessageToolBar : UIToolbar{
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var messageTextView: CustomTextView?
    var threasholdOfTextViewHeight: CGFloat = 0
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addButtons()
    }
    func addButtons(){
        let addbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtn))
        messageTextView = getTextView()
        let textview = UIBarButtonItem(customView: messageTextView!)
        let cambtn = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addBtn))
        let audiobtn = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addBtn))

        items = [addbutton,textview,cambtn,audiobtn]
        
    }
    
    func getTextView()->CustomTextView{
        let width = UIScreen.main.bounds.width-3*(45)
        let textView = CustomTextView(frame: CGRect.zero )
        textView.frame.size.width = width
        textView.layer.cornerRadius = 20
        textView.layer.borderColor = UIColor.seperatorColor.cgColor
        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.autocorrectionType = .no
        textView.editingChanged = {
           (text,_) in
           // trigger your animation here
           self.resizeHeightOfMsgTxvtV(text: text)
       }
        textView.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        textView.isScrollEnabled = true
        return textView
    }
    func resizeHeightOfMsgTxvtV(text : String?){
        if messageTextView == nil{return}
        let numberOfLines = getNumberOfLine()
        if numberOfLines < 5{
            messageTextView?.frame = CGRect(x: 0, y: 0, width: messageTextView!.frame.width, height: messageTextView!.contentSize.height)
        }
        
    }
    @objc func addBtn(){
        
        
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if messageTextView == nil{return}
        if keyPath == "frame"
        {
            let numberOfLines = getNumberOfLine()
            if numberOfLines <= 5{
                self.heightConstraint.constant = self.messageTextView!.frame.height + 9
            }
            
            if numberOfLines == 5{
                threasholdOfTextViewHeight = self.messageTextView!.frame.height
            }
            
        }
        
    }
    
    func getNumberOfLine()->Int{
        if messageTextView == nil{return 0}
//        let newSize = self.messageTextView!.sizeThatFits(CGSize(width: self.messageTextView!.frame.width, height: CGFloat.greatestFiniteMagnitude))
        let numberOfLine = self.messageTextView!.calculateMaxLines()
        return numberOfLine
    }
}
