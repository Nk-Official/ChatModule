//
//  ContactMsgTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 25/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Contacts
import SDWebImage
class ContactMsgTableViewCell: MessageTableViewCell{
    
    //MARK: - OUTLET
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var profileImgView : UIImageView!
    
    var contacts: [CNContact]?
    
    //MARK: - UI SETUP
    override func configureUI() {
        super.configureUI()
        
        if message == nil{
            nameLbl.text = "-----"
            profileImgView.image = UIImage(named: "placeholderUserImg")
            return
        }
        timeLbl.text = dateManager.getTime(from: message.sendDateTime)
        msgStateImgV.image = getMessageStateImg()
        guard let contactsUrl = message.contacts else {
            return
        }
        let key = "contact"+contactsUrl
        let cache = SDImageCache.shared // this is hack to save contact data to cache
        
        if let data = cache.diskImageData(forKey: key){
            do{
                let contacts = try CNContactVCardSerialization.contacts(with: data)
                DispatchQueue.main.async {
                    self.configureCell(with: contacts.last!)
                }
            }
            catch(let error){
                fatalError(error.localizedDescription)
            }
            return
        }
        
        fetchDataFromURL(url: contactsUrl) { (data) in
            if data != nil{
                do{
                    let contacts = try CNContactVCardSerialization.contacts(with: data!)
                    cache.storeImageData(toDisk: data!, forKey: key)
                    self.contacts = contacts
                    print("contacts get ",contacts)
                    DispatchQueue.main.async {
                        self.configureCell(with: contacts.last!)
                    }
                }
                catch{
                    print("error while decoding",error.localizedDescription)
                }
            }
        }        
    }
    
    
    func configureCell(with contact: CNContact){
        nameLbl.text = contact.givenName
    }
    
}
