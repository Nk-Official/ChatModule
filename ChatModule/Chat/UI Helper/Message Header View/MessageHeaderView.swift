//
//  MessageHeaderView.swift
//  ChatModule
//
//  Created by user on 11/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class MessageHeaderView: UIView {
    //MARK: - OUTLETS

    @IBOutlet weak private var contentV : UIView!
    @IBOutlet weak private var nameLbl : UILabel!
    @IBOutlet weak private var msgTypeImgView : UIImageView!
    @IBOutlet weak private var msgTypeLbl : UILabel!

    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit(){
        Bundle.main.loadNibNamed("MessageHeaderView", owner: self, options: nil)
        self.addSubview(contentV)
        contentV.frame = self.bounds
        contentV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentV.frame = self.bounds
    }

}
