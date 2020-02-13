//
//  ContactTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 11/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView : UIImageView!
    @IBOutlet weak var usernameLbl : UILabel!
    @IBOutlet weak var lastMsgLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var unreadMsgCountLbl : UILabel!
    @IBOutlet weak var muteImageView : UIImageView!
    
    var dateManager : DateManager!
    var prefrences: ContactsPrefrences =  ContactsPrefrences()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        unreadMsgCountLbl.layer.cornerRadius = unreadMsgCountLbl.frame.height/2
        unreadMsgCountLbl.clipsToBounds = true
    }
    
    func configureCell(channel : Channel){
        configureUI()
        usernameLbl.text = channel.name
        lastMsgLbl.text = channel.lastMessage?.message
        userImageView.setImage(from: channel.profile,placeholderImage: UIImage(named:"placeholderUserImg") )
        dateLbl.text = nil
        guard let dateDiff = dateManager.daysFromTodaysDate(from: channel.lastMessage?.sendDateTime ?? "")else{
            return
        }
    
        switch dateDiff {
        case .today:
            let time = dateManager.getTime(from: channel.lastMessage?.sendDateTime ?? "")
            dateLbl.text = time
        case.yesterday:dateLbl.text = "Yesterday"
        case .gapFromToday(_):
            let date = dateManager.convertFormat(from: channel.lastMessage?.sendDateTime ?? "")
            dateLbl.text = date
        }
        
    }
    
    private func configureUI(){
        usernameLbl.isHidden = !prefrences.showName
        lastMsgLbl.isHidden = !prefrences.showLastMessage
        userImageView.isHidden = !prefrences.showProfileIcon
        dateLbl.isHidden = !prefrences.showDate
        muteImageView.isHidden = !prefrences.showMuteOption
        unreadMsgCountLbl.isHidden = !prefrences.showUnreadMessagesCount
        
        usernameLbl.font = prefrences.nameFont
        lastMsgLbl.font = prefrences.lastMessageFont
        dateLbl.font = prefrences.dateFont
        unreadMsgCountLbl.font = prefrences.unreadMessageCountFont
        
        usernameLbl.textColor = prefrences.nameColor
        lastMsgLbl.textColor = prefrences.lastMessageColor
        dateLbl.textColor = prefrences.dateColor
        unreadMsgCountLbl.textColor = prefrences.unreadMessageCountColor
        
        muteImageView.image = prefrences.muteIcon
        unreadMsgCountLbl.backgroundColor = prefrences.unreadMessageCountBackgroundColor
        
    }
}
