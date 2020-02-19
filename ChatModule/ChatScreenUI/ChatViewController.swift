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
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var bgImgView : UIImageView!
    @IBOutlet weak var composeMsgView :ComposeMessageView!
    @IBOutlet weak var channelProfileView : UIImageView!
    @IBOutlet weak var channelNameLbl : UILabel!
    
    //MARK: - IBACTION
    @IBAction func video(_ sender: UIButton){
     
    }
    @IBAction func call(_ sender: UIButton){
     
    }
    
    //MARK: - PROPERTIES
    var viewModel : ChatViewModel!
    let disposablebag = DisposeBag()
    var dateManager = DateManager()
    var userid : String{
        return CommonFunctions.loginUserUdId()
    }
    var receiver :  Channel!
    var delegate : ChatDelegate!
    var dataSource: ChatDataSource!
    var backDelegate: BackNavigateDelegate?
    
    //MARK: - INHERITANCE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChatViewModel(userId: userid)
        setUI()
        bindMessagesWithTV()
        composeMsgView.delegate = self
        getAllMessages()
        setUpNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToBottom()
    }
    //MARK: - METHODS
    func getAllMessages(){
        let receiverId = receiver.id
        dataSource.messages(self, receiver: receiverId) { (messages) in
            self.viewModel.messages.accept(messages)
            print(messages)
        }
    }
    func refresh(message : [DayMessages]){
        viewModel.messages.accept(message)
        
    }
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            if let index = self.viewModel.lastIndex{
                self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
            }
        }
    }
    func setUI(){
        
        let theme = DBManager().chatTheme
        self.view.backgroundColor = theme.chatBackgroundColor
        self.bgImgView.image = theme.chatBackgroundImage
        channelProfileView.setImage(from: receiver.profile)
        channelNameLbl.text = receiver.name
    }
    func setUpNavigationBar(){
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    @IBAction func back(sender: UIBarButtonItem) {
        backDelegate?.moveBackScreen(from: self)
    }
    func bindMessagesWithTV(){
        
        //rxswift not support multiple section
        //use rxdatasource
        viewModel.messages.subscribe({ (_) in
            self.tableView.reloadData()
            self.scrollToBottom()
        }) .disposed(by: disposablebag)
        viewModel.messages.subscribe({_ in self.scrollToBottom()}).disposed(by: disposablebag)
        tableView.rx.setDelegate(self).disposed(by: disposablebag)
        tableView.rx.setDataSource(self).disposed(by: disposablebag)
    }
    func openImage(image : UIImage,username: String, date: String){
        let vc = ImageMessageViewerViewController.initiatefromStoryboard(.main)
        vc.image = image
        vc.date = date
        vc.name = username
        present(vc, animated: true, completion: nil)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - UITableViewDataSource
extension ChatViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.messages.value.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.value[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        let message = viewModel.messages.value[section].messages[row]
        let messageType = message.getMessageType()
        let incoming : Bool = (message.senderId != userid)
        
        var messageCell : MessageTableViewCell
        
        switch messageType {
        case .text:
            if incoming{
                if let cell = dataSource.incomingTextMessageBubble(self, message: message){messageCell = cell}
                else{messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingTextCell, for: indexPath) as! MessageTableViewCell}
            }else{
                if let cell = dataSource.outgoingTextMessageBubble(self, message: message){messageCell = cell}
                else{messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingTextCell, for: indexPath) as! MessageTableViewCell}
            }
        case .image:
            if incoming{
                if let cell = dataSource.incomingImageMessageBubble(self, message: message){messageCell = cell}
                else{ let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingImageCell, for: indexPath) as! ImageMsgTableViewCell
                    cell.imageTap = {
                        (_,image) in
                        let name = message.senderId == self.receiver.id ? self.receiver.name : "You"
                        self.openImage(image: image, username: name, date: message.sendDateTime)
                    }
                    messageCell = cell
                }
            }else{
                if let cell = dataSource.outgoingImageMessageBubble(self, message: message){messageCell = cell}
                else{  let cell  = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingImageCell, for: indexPath) as! ImageMsgTableViewCell
                    cell.imageTap = {
                        (_,image) in
                        let name = message.senderId == self.receiver.id ? self.receiver.name : "You"
                        self.openImage(image: image, username: name, date: message.sendDateTime)
                    }
                    messageCell = cell
                }
            }
        case .video:
            if incoming{
                if let cell = dataSource.incomingVideoMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingVideoCell, for: indexPath) as! MessageTableViewCell}
            }else{
                if let cell = dataSource.outgoingVideoMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingVideoCell, for: indexPath) as! MessageTableViewCell}
            }
        case .audio:
            if incoming{
                if let cell = dataSource.incomingAudioMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingAudioCell, for: indexPath) as! MessageTableViewCell}
            }else{
                if let cell = dataSource.outgoingAudioMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingAudioCell, for: indexPath) as! MessageTableViewCell}
            }
        case .file:
            if incoming{
                if let cell = dataSource.incomingFileMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingFileCell, for: indexPath) as! MessageTableViewCell}
            }else{
                if let cell = dataSource.outgoingFileMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingFileCell, for: indexPath) as! MessageTableViewCell}
            }
        }
        messageCell.dateManager = dateManager
        messageCell.message = message
        return messageCell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let date = viewModel.messages.value[section].messages.first!.sendDateTime
        let view = InformationView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44) )
        
        guard let dateDiff = dateManager.daysFromTodaysDate(from: date)else{
            return nil
        }
        var title : String = ""
        switch dateDiff {
        case .today:title = "Today"
        case.yesterday:title = "Yesterday"
        case .gapFromToday(_):
            title = viewModel.messages.value[section].date
        }
        view.configure(message: title, leftIcon: nil)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}


//MARK: - ComposeMssageDelegate
extension ChatViewController : ComposeMssageDelegate{
    
    func textMessageSent(_ composeMessageView: ComposeMessageView, message: String) {
        let sendtime = dateManager.getCurrentDateTime()
        let receiverId = receiver.id
        let message = Message(senderId: userid, receiverId: receiverId, message: message, sendDateTime: sendtime)
       
        delegate.didSendMessage(self, message: message, to: receiverId)
    }
    
    func audioMessageSent(_ composeMessageView: ComposeMessageView, audioUrl: URL) {
        let sendtime = dateManager.getCurrentDateTime()
        let receiverId = receiver.id
        let message = Message(senderId: userid, receiverId: receiverId, audioMsg: "\(audioUrl)" , sendDateTime: sendtime)
        delegate.didSendAudioMessage(self, message: message, to: receiverId, localfile: audioUrl)
    }
    
    func imageMessageSent(_ composeMessageView: ComposeMessageView, images: [UIImage]) {
       let sendtime = dateManager.getCurrentDateTime()
        let receiverId = receiver.id
        let message = Message(senderId: userid, receiverId: receiverId, imageMsg: "", sendDateTime: sendtime)
        delegate.didSendPhotoMessage(self, message: message, to: receiverId, images: images)
    }

//    func textMessageSent(view: ComposeMessageView, message: String) {
//        let msg = Message(message: message, senderId: userid, sendTime: "12:00 am", deliveryTime: "", readTime: "")
//        viewModel.messages.accept(viewModel.messages.value + [msg])
//    }
}
