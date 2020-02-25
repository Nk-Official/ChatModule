//
//  ContactMsgTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 25/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Contacts

class ContactMsgTableViewCell: MessageTableViewCell{
    
    //MARK: - OUTLET
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var profileImgView : UIImageView!
    
    //MARK: - UI SETUP
    override func configureUI() {
        super.configureUI()
        
        if message == nil{
            nameLbl.text = "-----"
            profileImgView.image = UIImage(named: "placeholderUserImg")
            return
        }
        guard let contactsUrl = message.contacts else {
            return
        }
        fetchDataFromURL(url: contactsUrl) { (data) in
            if data != nil{
                do{
                    let contacts = try CNContactVCardSerialization.contacts(with: data!)
                    print("contacts get ",contacts)
                    self.configureCell(with: contacts.last!)
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
    func fetchDataFromURL(url string: String,completion: @escaping (Data?)->()){
        guard let url = URL(string: string) else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("error while fetching data",error!.localizedDescription)
            }
            completion(data)
        }.resume()
    }
}
