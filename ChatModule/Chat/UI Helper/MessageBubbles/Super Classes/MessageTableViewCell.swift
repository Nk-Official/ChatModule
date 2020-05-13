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
    var isGroupChat: Bool = false
    var dateManager : DateManager!
    private var headerView: MessageHeaderView?
    
    //MARK: - IBOUTLET
    @IBOutlet weak   var msgBackgroundView : UIView!
    @IBOutlet weak   var timeLbl : UILabel!
    @IBOutlet weak   var msgStateImgV : UIImageView!
    @IBOutlet weak   var messageHeaderView : UIStackView?

    //MARK: - METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        setUIAccToTheme()
        configureUI()
    }
    
    
    func configureUI(){
    }
    
    
    
    func setUIAccToTheme(){
        self.msgBackgroundView.layer.cornerRadius = 5
        self.msgBackgroundView.clipsToBounds = true
        addHeaderView()
    }
    func addHeaderView(){
        
        let headerview = MessageHeaderView(frame: .zero)
        if messageHeaderView != nil, headerView == nil,isGroupChat{
            self.headerView = headerview
            messageHeaderView!.addArrangedSubview(headerview)
        }
        
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
    
    
    //MARK: - NETWORK
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

