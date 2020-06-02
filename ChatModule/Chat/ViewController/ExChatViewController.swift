//
//  ExChatViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 27/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit


extension ChatViewController{
    
    func tapToHideKeyboard(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(tableTap) )
        tableView.addGestureRecognizer(tapGesture)
        
    }
    @objc func tableTap(_ longPressGestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    //MARK: - LONG PRESS GESTURE
    func longPressGestureToMesages(){
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {

        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
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
        setAlphaOfBackgroundViews(alpha: 1)
    }
   func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
       setAlphaOfBackgroundViews(alpha: 1)
   }
   func setAlphaOfBackgroundViews(alpha: CGFloat) {
       UIView.animate(withDuration: 0.2) {
           self.view.alpha = alpha;
           self.navigationController?.navigationBar.alpha = alpha;
       }
   }
    
}

//MARK: - CUSTOM NAVIGATION BAR BUTTON
extension ChatViewController {

    func customizeNavigationBar(){
        settitleView()
        setBackButton()
        let videoBtn = UIBarButtonItem(image: UIImage(named: "videoCam2"), style: .plain, target: self, action: #selector(videoBtnPress))
        let callBtn = UIBarButtonItem(image: UIImage(named: "callIcon2"), style: .plain, target: self, action: #selector(callBtnPress))

        navigationItem.rightBarButtonItems = [callBtn,videoBtn]
        
    }
    func setBackButton(){
        let leftBarBtn = UIBarButtonItem(image: UIImage(named: "back3"), style: .plain, target: self, action: #selector(popToBack))
        navigationItem.leftBarButtonItem = leftBarBtn
    }
    @objc func popToBack(){
        navigationController?.popViewController(animated: true)
    }
    @objc func callBtnPress(){
        debugPrint("callBtnPress")
    }
    @objc func videoBtnPress(){
       debugPrint("videoBtnPress")
    }
    func settitleView(){
        let imageView = UIImageView()
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 36),
            imageView.widthAnchor.constraint(equalToConstant: 36)
        ])
        imageView.setImage(from: receiver.profile)
        imageView.layer.cornerRadius = 18
        
        let titleLabel = UILabel()
        titleLabel.text = receiver.name
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        let subtitle = UILabel()
        subtitle.text = "last seen today at 10:19 Am   "
        subtitle.textColor = UIColor(0x818387)
        subtitle.font = UIFont.boldSystemFont(ofSize: 14)


        let vStack = UIStackView(arrangedSubviews: [titleLabel,subtitle])
        vStack.axis = .vertical
        vStack.alignment = .leading
        
        let hStack = UIStackView(arrangedSubviews: [imageView, vStack])
        hStack.spacing = 10
        hStack.alignment = .leading

        navigationItem.titleView = hStack
        hStack.isUserInteractionEnabled = true
        let tg = UITapGestureRecognizer(target: self, action: #selector(contactInfoTap))
        hStack.addGestureRecognizer(tg)
    }
    
    @objc func contactInfoTap(){
        
        if receiver.isGroup == 1{
           let coordinator = ContactInfoCoordinator(navigationController: navigationController!)
           coordinator.start()
       }
    }

}
