//
//  MessagePopOverViewController.swift
//  ChatModule
//
//  Created by user on 29/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//
import UIKit

class MessagePopOverViewController: UIViewController {

    //MARK: -
    @IBOutlet weak var msglabel : UILabel!
    @IBOutlet weak var closeButton : UIButton!
    @IBOutlet weak var stackView: UIStackView!

    @IBAction func close(_ sender: UIButton){
//        UIView.animate(withDuration: 0.2, animations: {
//            let popover: UIPopoverPresentationController? = self.popoverPresentationController
//            popover?.backgroundColor = .clear
//            self.view.alpha = 0
//        }) { (_) in
            self.dismiss(animated: true, completion: nil)
//        }
    }
    
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.showsTouchWhenHighlighted = true
        msglabel.text = message
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        preferredContentSize = CGSize(width: stackView.frame.width+10 , height: stackView.frame.height)
    }
}
