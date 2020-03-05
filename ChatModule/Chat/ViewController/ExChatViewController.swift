//
//  ExChatViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 27/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit


extension ChatViewController{
    
    
    //MARK: -  GESTURE
    func longPressGestureToMesages(){
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {

        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                print("indexpath",indexPath)
                guard let cell = tableView.cellForRow(at: indexPath) as? MessageTableViewCell else {
                    return
                }
                messageInterprator = MessageInterprator(chat: self, tableView: tableView, messageCell: cell)
                messageInterprator?.present()
                
            }
        }
    }
}



//MARK: - UIPopoverPresentationControllerDelegate

extension ChatViewController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        messageInterprator?.remove(with: true)
    }
    
}
