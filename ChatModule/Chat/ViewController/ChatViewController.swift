//
//  ChatViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation
import Contacts

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
    
    @IBAction func back(sender: UIBarButtonItem) {
        backDelegate?.moveBackScreen(from: self)
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
    var navigator: ChatScreenNavigator!
    var logInUser: Channel!
    override var canBecomeFirstResponder: Bool{
        return true
    }
    //MARK: - INHERITANCE
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChatViewModel(userId: userid)
        setUI()
        bindMessagesWithTV()
        setComposeMsgView()
        getAllMessages()
        longPressGestureToMesages()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToBottom()
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return true
    }
    //MARK: - METHODS
    func getAllMessages(){
        let receiverId = receiver.id
        dataSource.messages(self, receiver: receiverId) { (messages) in
            self.viewModel.messages.accept(messages)
            print(messages)
        }
    }
    
    func setUI(){
        
        let theme = DBManager().chatTheme
        self.view.backgroundColor = theme.chatBackgroundColor
        self.bgImgView.image = theme.chatBackgroundImage
        channelProfileView.setImage(from: receiver.profile)
        channelNameLbl.text = receiver.name
    }
    func setComposeMsgView(){
        composeMsgView.delegate = self
        composeMsgView.locationPickerDelegate = self
    }
    //MARK: - UI ACTION
    func openImage(image : UIImage,username: String, date: String){
        let vc = ImageMessageViewerViewController.initiatefromStoryboard(.main)
        vc.image = image
        vc.date = date
        vc.name = username
        present(vc, animated: true, completion: nil)
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            if let index = self.viewModel.lastIndex{
                self.tableView.scrollToRow(at: index, at: .bottom, animated: false)
            }
        }
    }
    //MARK: - BINDABLE
    func refresh(message : [DayMessages]){
        viewModel.messages.accept(message)
        
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
        let row = indexPath.row
        let section = indexPath.section
        let message = viewModel.messages.value[section].messages[row]
        let messageType = message.getMessageType()
        switch messageType {
        case .location:
            if message.location!.live == 1{
                if message.receiverId == userid{
                    navigator.moveToLocationViewerScreen(self, locations: [message.location!], sender: receiver)
                }else{
                    navigator.moveToLocationViewerScreen(self, locations: [message.location!], sender: logInUser)
                }
            }else{
                let url = "comgooglemaps://?center=\(message.location!.latitude),\(message.location!.longitude)&zoom=14&views=traffic"
                if UIApplication.shared.canOpenURL(URL(string: url)!){
                    UIApplication.shared.open(URL(string: url)!)
                }else{
                    showAlert(title: "Error", message: "Not getting any application for open location", okAction: nil)
                }
            }
        case .contact:
            if message.senderId != userid{
                guard let cell = tableView.cellForRow(at: indexPath) as? ContactMsgTableViewCell else {
                    return
                }
                let manager = ContactManager()
                guard let contacts = cell.contacts else{
                    return
                }
                do{
                    try manager.saveContactToContacts(contacts: contacts)
                    self.showAlert(title: "Success", message: "Contact added successfully", okAction: nil)
                }catch{
                    self.showAlert(title: "Error", message: error.localizedDescription, okAction: nil)
                }
            }
        default:
            break
        }
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
        
        if incoming{
            switch messageType {
            case .text:
                if let cell = dataSource.incomingTextMessageBubble(self, message: message){messageCell = cell}
                else{messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingTextCell, for: indexPath) as! MessageTableViewCell}
            case .image:
                if let cell = dataSource.incomingImageMessageBubble(self, message: message){messageCell = cell}
                else{ let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingImageCell, for: indexPath) as! ImageMsgTableViewCell
                    cell.imageTap = {
                        (_,image) in
                        let name = message.senderId == self.receiver.id ? self.receiver.name : "You"
                        self.openImage(image: image, username: name, date: message.sendDateTime)
                    }
                    messageCell = cell
                }
            case .video:
                if let cell = dataSource.incomingVideoMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingVideoCell, for: indexPath) as! MessageTableViewCell}
            case .audio:
                if let cell = dataSource.incomingAudioMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.incomingAudioCell, for: indexPath) as! MessageTableViewCell}
            case .file:
                if let cell = dataSource.incomingFileMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = Bundle.main.loadNibNamed(viewModel.incomingFileCell, owner: self, options: nil)?.first as! MessageTableViewCell}
            case .location:
                if let cell = dataSource.incomingLocationMessageBubble(self, message: message){messageCell = cell}
                else{  let cell  = Bundle.main.loadNibNamed(viewModel.incomingLocationCell, owner: self, options: nil)?.first as! LocationMsgTavleViewCell
                messageCell = cell}
            case .contact:
                if let cell = dataSource.incomingContactMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = Bundle.main.loadNibNamed(viewModel.incomingContactCell, owner: self, options: nil)?.first as! MessageTableViewCell
                }
            }
        }else{
            switch messageType {
            case .text:
                if let cell = dataSource.outgoingTextMessageBubble(self, message: message){messageCell = cell}
                else{messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingTextCell, for: indexPath) as! MessageTableViewCell}
            case .image:
                let cell  = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingImageCell, for: indexPath) as! ImageMsgTableViewCell
                cell.imageTap = {
                    (_,image) in
                    let name = message.senderId == self.receiver.id ? self.receiver.name : "You"
                    self.openImage(image: image, username: name, date: message.sendDateTime)
                }
                messageCell = cell
            case .video:
                if let cell = dataSource.outgoingVideoMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingVideoCell, for: indexPath) as! MessageTableViewCell}
            case .audio:
                if let cell = dataSource.outgoingAudioMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = tableView.dequeueReusableCell(withIdentifier: viewModel.outgoingAudioCell, for: indexPath) as! MessageTableViewCell}
            case .file:
                if let cell = dataSource.outgoingFileMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = Bundle.main.loadNibNamed(viewModel.outgoingFileCell, owner: self, options: nil)?.first as! MessageTableViewCell}
            case .location:
                if let cell = dataSource.outgoingLocationMessageBubble(self, message: message){messageCell = cell}
                else{  let cell  = Bundle.main.loadNibNamed(viewModel.outgoingLocationCell, owner: self, options: nil)?.first as! LocationMsgTavleViewCell
                    messageCell = cell
                }
            case .contact:
                if let cell = dataSource.outgoingContactMessageBubble(self, message: message){messageCell = cell}
                else{  messageCell = Bundle.main.loadNibNamed(viewModel.outgoingContactCell, owner: self, options: nil)?.first as! MessageTableViewCell
                }
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

    func contactMessageSent(_ composeMessageView: ComposeMessageView, contacts: [CNContact]) {
        let sendtime = dateManager.getCurrentDateTime()
        let receiverId = receiver.id
        let message = Message(senderId: userid, receiverId: receiverId,  contacts: nil, sendDateTime: sendtime)
        delegate.didSendContactMessage(self, message: message, to: receiverId, contacts: contacts)
       
    }
    func fileMessageSent(_ composeMessageView: ComposeMessageView, url: URL) {
        let sendtime = dateManager.getCurrentDateTime()
        let receiverId = receiver.id
        let message = Message(senderId: userid, receiverId: receiverId,  file: url.absoluteString, sendDateTime: sendtime)
        delegate?.didSendFileMessage(self, message: message, to: receiverId, fileAt: url)
    }
//    func textMessageSent(view: ComposeMessageView, message: String) {
//        let msg = Message(message: message, senderId: userid, sendTime: "12:00 am", deliveryTime: "", readTime: "")
//        viewModel.messages.accept(viewModel.messages.value + [msg])
//    }
}

extension ChatViewController: LocationPickerDelegate{
    func didPickLocation(_ viewController: LocationPickerViewController, coordinates: CLLocationCoordinate2D, isLive: Bool) {
        let receiverId = receiver.id
        let live = isLive ? 1 : 0
        let sendtime = dateManager.getCurrentDateTime()
        let location = Location(latitude: coordinates.latitude, longitude: coordinates.longitude, live: live,  updateTime: sendtime)
        let message = Message(senderId: userid, receiverId: receiverId,  location: location, sendDateTime: sendtime)
        delegate.didSendLocationMessage(self, message: message, to: receiverId)
        viewController.pop()
    }
}
