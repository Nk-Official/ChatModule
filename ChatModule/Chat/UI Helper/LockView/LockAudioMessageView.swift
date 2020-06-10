//
//  LockAudioMessageView.swift
//  ChatModule
//
//  Created by user on 04/06/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
class LockAudioMessageView: UIView {
    
    //MARK: - OUTLETS

    @IBOutlet weak private var contentV : UIView!
    @IBOutlet weak private var lockImageView : UIImageView!
    @IBOutlet weak private var arrowImageView : UIImageView!

    
    private var firstAnimationDone: Bool = false
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
        Bundle.main.loadNibNamed("LockAudioMessageView", owner: self, options: nil)
        self.addSubview(contentV)
        contentV.frame = self.bounds
        contentV.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentV.isHidden = true
        
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        animateArrowUpandDown()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !firstAnimationDone{
            firstAnimationDone = true
            self.transform = CGAffineTransform(translationX: 0, y: self.frame.height)
             self.contentV.isHidden = false
            contentV.alpha = 1
            UIView.animate(withDuration: 0.4) {
                self.transform = .identity
                self.contentV.alpha = 1
            }
        }
        roudThecornors()
    }
    
    
    
    
    
    func roudThecornors(){
        let radius = frame.width/2
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight,.topLeft], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        //setup Border for Mask
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.lineWidth = 1
        borderLayer.strokeColor = UIColor.seperatorColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(borderLayer)
    }
    
    func animateArrowUpandDown(){
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: [UIView.AnimationOptions.autoreverse,.repeat], animations: {
            self.arrowImageView.transform = CGAffineTransform(translationX: 0, y: 10)
            self.lockImageView.transform = CGAffineTransform(translationX: 0, y: -5)

        }) { (_) in
//            self.arrowImageView.alpha = 1
        }
    }
}

