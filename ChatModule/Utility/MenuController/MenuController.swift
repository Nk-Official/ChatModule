//
//  MenuController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 27/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
class MenuController {
    
    let menuController: UIMenuController = UIMenuController()
    
    
    func setMenuController(){
        
        menuController.arrowDirection = .default
//        menuController.setTargetRect(.zero, in: view)
        
        let menuItem1: UIMenuItem = UIMenuItem(title: "Menu 1", action: #selector(menuActions(_:)))
        let menuItem2: UIMenuItem = UIMenuItem(title: "Menu 2", action: #selector(menuActions(_:)))
        let menuItem3: UIMenuItem = UIMenuItem(title: "Menu 3", action: #selector(menuActions(_:)))
        
        // Store MenuItem in array.
        let myMenuItems: [UIMenuItem] = [menuItem1, menuItem2, menuItem3]
        
        menuController.menuItems = myMenuItems
    }
    @objc func menuActions(_ sender: UIMenuItem){
        
        print("tap")
        
    }
    
    
    func showMenu(inview: UIView){
        inview.becomeFirstResponder()
        menuController.setTargetRect(.zero, in: inview)
        menuController.setMenuVisible(true, animated: true)
    }
    func hideMenu(){
        menuController.setMenuVisible(false, animated: true)
    }
    
}
