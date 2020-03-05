//
//  MessageAccessiblityViewModel.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 28/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class MessageAccessiblityPresentor {
    
    
    init(presentOver viewController: ChatViewController,message: Message, incomingMesage: Bool) {
        self.message = message
        self.incoming = incomingMesage
        self.viewController = viewController
    }
    
    var message: Message
    var incoming: Bool
    var viewController: ChatViewController
    //MARK: - MENU ITEM
    lazy var starItem : PopUpMenuItem = {
        PopUpMenuItem(title: "Star", image: UIImage(named: "filledStar_black")) { (row, item) in
            
        }
    }()
    lazy var replyItem : PopUpMenuItem = {
        PopUpMenuItem(title: "Reply", image: UIImage(named: "reply_black")) { (row, item) in
            
        }
    }()
    lazy var forwardItem : PopUpMenuItem = {
        PopUpMenuItem(title: "Forward", image: UIImage(named: "forward_black")) { (row, item) in
            
        }
    }()
    lazy var copyItem : PopUpMenuItem = {
        PopUpMenuItem(title: "Copy", image: UIImage(named: "copy_black")) { (row, item) in
            
        }
    }()
    lazy var infoItem : PopUpMenuItem = {
        PopUpMenuItem(title: "Info", image: UIImage(named: "info_black")) { (row, item) in
            
        }
    }()
    lazy var deleteItem : PopUpMenuItem = {
        PopUpMenuItem(title: "Delete", image: UIImage(named: "delete_black")) { (row, item) in
            
        }
    }()
    
    //MARK: - MENU ITEM ACCORDING TO MESSAGE TYPE
    private func getMenuItems() -> [PopUpMenuItem]{
        var menuItems = [PopUpMenuItem]()
        let messageType = message.getMessageType()
        
        if incoming{
            switch messageType {
            case .text:  menuItems = [starItem,replyItem,forwardItem,copyItem,deleteItem]
            case .image: menuItems = [starItem,replyItem,forwardItem,deleteItem]
            case .video: menuItems = [starItem,replyItem,forwardItem,deleteItem]
            case .audio: menuItems = [starItem,replyItem,forwardItem,deleteItem]
            case .contact: menuItems = [starItem,replyItem,forwardItem,deleteItem]
            case .file: menuItems = [starItem,replyItem,forwardItem,deleteItem]
            case .location: menuItems = [starItem,replyItem,forwardItem,deleteItem]
            }
        }else{
            switch messageType {
            case .text: menuItems = [starItem,replyItem,forwardItem,copyItem,infoItem,deleteItem]
            case .image: menuItems = [starItem,replyItem,forwardItem,infoItem,deleteItem]
            case .video: menuItems = [starItem,replyItem,forwardItem,infoItem,deleteItem]
            case .audio: menuItems = [starItem,replyItem,forwardItem,infoItem,deleteItem]
            case .contact: menuItems = [starItem,replyItem,forwardItem,infoItem,deleteItem]
            case .file: menuItems = [starItem,replyItem,forwardItem,infoItem,deleteItem]
            case .location: menuItems = [starItem,replyItem,forwardItem,infoItem,deleteItem]
            }
        }
        
        return menuItems
    }
    
    //MARK: - PRESENT MENU ITEM
    func presentMenuPopUp( anchorView: UIView,menuItems: [PopUpMenuItem]? = nil){
        
        let items = menuItems ?? getMenuItems()
        
        
        let popUpViewController = MenuPopOverViewController.initiatefromStoryboard(.main)
        popUpViewController.menuItems = items
        
        popUpViewController.modalPresentationStyle = .popover
        let popoverc = popUpViewController.popoverPresentationController
        if let delegate = viewController as? UIPopoverPresentationControllerDelegate{
            popoverc?.delegate = delegate
        }
        else{
            fatalError("implement delegate in presented viewcontroller")
        }
        popoverc?.barButtonItem = UIBarButtonItem(customView: anchorView)
        viewController.present(popUpViewController, animated: true, completion: nil)
        
    }
    
}



