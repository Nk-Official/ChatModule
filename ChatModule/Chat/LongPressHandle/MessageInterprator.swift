//
//  MessageInterprator.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 28/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class MessageInterprator {
    
    private let chatViewController: ChatViewController
    private let tableView: UITableView
    private let messageCell: MessageTableViewCell
 
    private var dimView: UIView?
    
    init(chat viewController: ChatViewController, tableView: UITableView, messageCell: MessageTableViewCell) {
        chatViewController = viewController
        self.tableView = tableView
        self.messageCell = messageCell
    }
    
    //MARK: - CONFIGURE
    private func configureAndPresent(){
        guard let presentOverView = chatViewController.view else{
            return
        }
        applyScaleThenBounceAnimation(to: messageCell)
        dimView = UIView(frame: presentOverView.bounds)
        dimView?.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        let scrnshot = messageCell.screenshot() // screen shot of cell to display highlighted cell and background gray(dim)
        let cellCopy = UIImageView(image: scrnshot)
        cellCopy.frame = tableView.convert(messageCell.frame, to: presentOverView)
        dimView?.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.dimView?.addSubview(cellCopy)
            self.dimView?.alpha = 1
        }
        presentOverView.addSubview(dimView!)
        gestureToRemoveAccesibiltyView()
        presentMenuOption(message: messageCell.message, anchorView: cellCopy)
    }
    //MARK: - ANIMATION
    func applyScaleThenBounceAnimation(to view: UIView){
        UIView.animate(withDuration: 0.2,
            animations: {
                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
//                    view.transform = CGAffineTransform.identity
                }
        })
    }
    //MARK: - GESTURE
    private func gestureToRemoveAccesibiltyView(){
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeSubview(_:)))
        dimView?.addGestureRecognizer(tapgesture)
        
    }
    @objc func removeSubview(_ tapGestureRecognizer: UITapGestureRecognizer){
        remove(with: true)
    }
    
    //MARK: - MessageAccessiblityPresentor
    private func presentMenuOption(message : Message, anchorView: UIView){
        let incoming =  message.senderId != chatViewController.userid
        let menuOptionPresentor = MessageAccessiblityPresentor(presentOver: chatViewController, message: message, incomingMesage: incoming)
        menuOptionPresentor.presentMenuPopUp(anchorView: anchorView)
    }
    
    //MARK: - DELEGATE
    
    func present(){
        
        configureAndPresent()
        
    }
    
    
    func remove(with animation: Bool){
        if dimView != nil{
            if animation{
                UIView.animate(withDuration: 0.3, animations: {
                    self.dimView!.alpha = 0
                    self.messageCell.transform = .identity
                }) { (_) in
                    
                    self.dimView!.removeFromSuperview()
                }
            }
            else{
                self.messageCell.transform = .identity
                self.dimView!.removeFromSuperview()
                
            }
        }
    }
}
