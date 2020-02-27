//
//  InformationView.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 13/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
class InformationView : UIView{
    //MARK: - OUTLET
    @IBOutlet weak var contentV : UIView!
    @IBOutlet weak var msglabel : UILabel!
    @IBOutlet weak var leftIconImageView : UIImageView!
    
    //MARK: - INITIALIZE
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    func commonInit(){
        Bundle.main.loadNibNamed("InformationView", owner: self, options: nil)
        self.addSubview(contentV)
        contentV.frame = self.bounds
        contentV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    //MARK: - CONFIGURE
    func configure(message: String, leftIcon : UIImage?){
        msglabel.text = message
        leftIconImageView.isHidden = leftIcon == nil
        leftIconImageView.image = leftIcon
    }
}
