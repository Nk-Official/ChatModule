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
                print("cell",cell)
                let bgView = UIView(frame: view.bounds)
                bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                
                let scrnshot = cell.screenshot()
                let cellCopy = UIImageView(image: scrnshot)
                cellCopy.frame = tableView.convert(cell.frame, to: self.view)
                bgView.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    bgView.addSubview(cellCopy)
                    bgView.alpha = 1
                }
                gestureToRemoveAccesibiltyView(bgView: bgView)
                self.view.addSubview(bgView)
            }
        }
    }

    func gestureToRemoveAccesibiltyView(bgView: UIView){
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeSubview(_:)))
        bgView.addGestureRecognizer(tapgesture)
        
    }
    @objc func removeSubview(_ tapGestureRecognizer: UITapGestureRecognizer){
        if let view = tapGestureRecognizer.view{
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0
            }) { (_) in
                view.removeFromSuperview()
            }
        }
    }
}
