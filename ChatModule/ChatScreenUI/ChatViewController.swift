//
//  ChatViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ChatViewController: UIViewController {

    //MARK: - IBOUTLET
    @IBOutlet weak var tableV : UITableView!
    @IBOutlet weak var bgImgV : UIImageView!
    @IBOutlet weak var composeMsgView :ComposeMessageView!
    
    //MARK: - PROPERTIES
    var viewModel : ChatViewModel!
    let disposablebag = DisposeBag()
    var dateManager = DateManager()
    var firebaseManager : FireBaseManager!
    var userid : String{
        return CommonFunctions.loginUserUdId()
    }
    var receiverId :  String!
    var delegate : ChatDelegate?
    var dataSource: ChatDataSource!
    
    
    //MARK: - INHERITANCE
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FireBaseManager()
        viewModel = ChatViewModel(userId: userid)
        setUI()
        bindMessagesWithTV()
        composeMsgView.delegate = self
        getAllMessages()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToBottom()
    }
    //MARK: - METHODS
    func getAllMessages(){
        
        dataSource.messages(self, receiver: receiverId) { (messages) in
            self.viewModel.messages.accept(messages)
        }
    }
    func scrollToBottom(){
        
//        DispatchQueue.main.async {
//            self.tableV.scrollToRow(at: self.viewModel.lastIndex, at: .bottom, animated: false)
//        }
    }
    func setUI(){
        
        let theme = DBManager().chatTheme
        self.view.backgroundColor = theme.chatBackgroundColor
        self.bgImgV.image = theme.chatBackgroundImage
    }
    func bindMessagesWithTV(){
        
        viewModel.messages.bind(to: tableV.rx.items) { (tableV, row, item) -> UITableViewCell in
            let cell = tableV.dequeueReusableCell(withIdentifier: self.viewModel.reuseId(msg: item), for: IndexPath(row: row, section: 0) ) as! MessageTableViewCell
            cell.message = item
            cell.dateManager = self.dateManager
            return cell
        }.disposed(by: disposablebag)
        viewModel.messages.subscribe({_ in self.scrollToBottom()}).disposed(by: disposablebag)
        tableV.rx.setDelegate(self).disposed(by: disposablebag)
        
        
    }
}

//MARK: - UITableViewDelegate

extension ChatViewController : UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
extension ChatViewController : ComposeMssageDelegate{
    func textMessageSent(_ composeMessageView: ComposeMessageView, message: String) {
        let sendtime = dateManager.getCurrentDateTime()
        let message = Message(senderId: userid, receiverId: receiverId, message: message, sendDateTime: sendtime)
        firebaseManager.sendMessage(toUser: receiverId, message: message)
        viewModel.messages.accept(viewModel.messages.value + [message])
    }
    
    func audioMessageSent(_ composeMessageView: ComposeMessageView, audioUrl: URL) {
        
    }
    
    
    
//    func audioMessageSent(view: ComposeMessageView, audioUrl: URL) {
//        let msg = Message( senderId: userid, sendTime: "12:00 am", deliveryTime: "12:01 am", readTime: "12:02 am", audioMsg: audioUrl)
//        viewModel.messages.accept(viewModel.messages.value + [msg])
//    }
//
//    func textMessageSent(view: ComposeMessageView, message: String) {
//        let msg = Message(message: message, senderId: userid, sendTime: "12:00 am", deliveryTime: "", readTime: "")
//        viewModel.messages.accept(viewModel.messages.value + [msg])
//    }
    
}
