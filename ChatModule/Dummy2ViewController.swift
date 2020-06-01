//
//  Dummy2ViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 14/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class Dummy2ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    //MARK: -
    @IBOutlet weak var messageComposeToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbarHeight: NSLayoutConstraint!

    var stackView: UIStackView?
    var textViewHeightConstraint : NSLayoutConstraint?
    var textView: UITextView?
    var addBtn: UIButton?
    var cameraBtn: UIButton?
    var microphoneBtn: UIButton?
    var sendMessageBtn: UIButton?

    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setUpToolBar()
//        let tp = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
//        view.addGestureRecognizer(tp)
    }
    @objc func tapGesture(){
        view.endEditing(true)
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
        messageComposeToolbar.items = [UIBarButtonItem(customView: stckView) ]
    }
}

extension Dummy2ViewController{
    
    func addButton()->UIButton{
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "addBlue") , for: .normal)
        addButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return addButton
    }
    func cameraButton()->UIButton{
        let addButton = UIButton()
        addButton.frame.size.width = 40
        addButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        addButton.setImage(UIImage(named: "cameraIcon") , for: .normal)
        return addButton
    }
    func microPhoneButton()->UIButton{
        let addButton = UIButton()
        addButton.frame.size.width = 40
        addButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        addButton.setImage(UIImage(named: "microphoneBlue") , for: .normal)
        return addButton
    }
    func sendMsgButton()->UIButton{
        let addButton = UIButton()
        addButton.frame.size.width = 40
        addButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        addButton.setImage(UIImage(named: "sendMessage") , for: .normal)
        addButton.backgroundColor = UIColor.blue
        addButton.layer.cornerRadius = min(addButton.frame.width,addButton.frame.height)/2
        addButton.clipsToBounds = true
        return addButton
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

extension Dummy2ViewController : UITextViewDelegate{
    
    
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
        print("djgfhgsdjh",self.microphoneBtn?.isHidden,self.cameraBtn?.isHidden,self.sendMessageBtn?.isHidden)
            return
        }
        [self.cameraBtn,self.microphoneBtn].forEach { (button) in
            button?.isHidden = true
        }
        self.sendMessageBtn?.isHidden = false
        
    }
    
}


extension Dummy2ViewController{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
