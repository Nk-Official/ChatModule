//
//  MessageCollectionViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 18/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

@_exported import UIKit


class MessageTableViewCell : UITableViewCell{
    
    //MARK: - PROPERTIES
    var message : Message!{
        didSet{
            configureUI()
        }
    }
    var theme : ChatTheme{
        return DBManager().chatTheme
    }
    var dateManager : DateManager!
    
    //MARK: - IBOUTLET
    @IBOutlet weak   var msgBackgroundView : UIView!
    @IBOutlet weak   var timeLbl : UILabel!
    @IBOutlet weak   var msgStateImgV : UIImageView!
    
    //MARK: - METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        setUIAccToTheme()
        configureUI()
//        layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    
    
    func configureUI(){
        
    }
    
    
    
    func setUIAccToTheme(){
        self.msgBackgroundView.layer.cornerRadius = 5
        self.msgBackgroundView.clipsToBounds = true
    }
    
    //MARK: - getMessageStateImg

    func getMessageStateImg()->UIImage{
        
        let state = message.getState()
        switch state {
        case .notSent:
            return UIImage(named: "notSentClock")!
        case .sent:
            return UIImage(named: "sentOnetick")!
        case .deliver:
            return UIImage(named: "deliverTwoTick")!
        case .read:
            return UIImage(named: "readTwoTick")!
        }
    }
    
}

