//
//  DummyViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import UIKit
class ResponsiveView: UIView {
override var canBecomeFirstResponder: Bool {
return true
    }
}

class DummyViewController: UIViewController , UITextFieldDelegate{
    

    let menuController: UIMenuController = UIMenuController.shared
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           view.becomeFirstResponder()

    }
    
    let audiomng = AudioRecorderManager(audioName: "recording", typeExt: "mpeg")
    @IBAction func record(_ sender: UIButton){
        sender.becomeFirstResponder()
//        audiomng.startRecording()
//        menu()
       
           menuController.setMenuVisible(true, animated: true)
           
        
           menuController.arrowDirection = UIMenuController.ArrowDirection.default
           
           menuController.setTargetRect(CGRect.zero, in: view)
           
           let menuItem1: UIMenuItem = UIMenuItem(title: "Menu 1", action: #selector(onMenu1(sender:)))
           let menuItem2: UIMenuItem = UIMenuItem(title: "Menu 2", action: #selector(onMenu2(sender:)))
           let menuItem3: UIMenuItem = UIMenuItem(title: "Menu 3", action: #selector(onMenu3(sender:)))
           
           // Store MenuItem in array.
           let myMenuItems: [UIMenuItem] = [menuItem1, menuItem2, menuItem3]
           
           // Added MenuItem to MenuController.
           menuController.menuItems = myMenuItems
        menuController.setMenuVisible(true, animated: true)

        print("Function: \(#function), line: \(#line) ",menuController.menuItems)
    }
    @IBAction func play(_ sender: UIButton){
//        audiomng.playAudio()
    }
    @IBAction func delete(){
        audiomng.deleteAudio()
    }
    @IBAction func stopRecording(){
        audiomng.finishRecording()
    }
    
    func menu(){
        let menuCntrl = MenuController()
        menuCntrl.setMenuController()
        menuCntrl.showMenu(inview: view)
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        print("Function: \(#function), line: \(#line)")
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Function: \(#function), line: \(#line)")
        return true
    }
    @objc internal func onMenu1(sender: UIMenuItem) {
        print("onMenu1")
    }
    
    @objc internal func onMenu2(sender: UIMenuItem) {
        print("onMenu2")
    }
    
    @objc internal func onMenu3(sender: UIMenuItem) {
        print("onMenu3")
    }
}
