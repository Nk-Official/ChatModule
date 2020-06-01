//
//  HindView.swift
//  ChatModule
//
//  Created by user on 29/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
class HintView : UIView{
    
    //MARK: - OUTLET
    @IBOutlet weak var contentV : UIView!
    @IBOutlet weak var msglabel : UILabel!

    
    @IBAction func close(_ sender: UIButton){
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
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
        Bundle.main.loadNibNamed("HintView", owner: self, options: nil)
        self.addSubview(contentV)
        contentV.frame = self.bounds
        contentV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    //MARK: - CONFIGURE
    func configure(message: String){
        msglabel.text = message
    }
    func presentHint(over anchorView: UIView){
        
        
        
        
    }
}
