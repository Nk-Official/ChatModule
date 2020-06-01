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

    
    @IBAction func close(_ sender: UIButton){
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.showsTouchWhenHighlighted = true
        msglabel.text = message
    }
    override func updateViewConstraints() {
        super.updateViewConstraints()
        see MenuPopOverViewController
        tableHeightCConstraint.constant = tableView.contentSize.height
        preferredContentSize = CGSize(width: 150, height: tableView.contentSize.height)
    }
}
