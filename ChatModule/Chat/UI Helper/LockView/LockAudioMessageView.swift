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
    
    func lockTheView(){
        self.arrowImageView.layer.removeAllAnimations()
        self.lockImageView.layer.removeAllAnimations()

        UIView.animate(withDuration: 0.4, animations: {
//            self.transform = CGAffineTransform(translationX: 0, y: -50)
        }) { (_) in
            UIView.animate(withDuration: 0.4, animations: {
                let height = (self.frame.size.width/self.frame.size.height)
                self.transform = self.transform.scaledBy(x: 1, y: height)
                print(self.frame,height)
                
                
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
//                 self.transform = self.transform.scaledBy(x: 2, y: 2)
                }) { (_) in

                }
            }
        }
        

//        let animLayer = CALayer() // the layer that is going to be animated
//        let cornerRadiusAnim = CABasicAnimation(keyPath: "cornerRadius") // the corner radius reducing animation
//        let widthAnim = CABasicAnimation(keyPath: "bounds.size.width") // the width animation
//        let groupAnim = CAAnimationGroup() // the combination of the corner and width animation
//        let animDuration = TimeInterval(1.0) // the duration of one 'segment' of the animation
//        let layerSize = CGFloat(100) // the width & height of the layer (when it's a square)
//
//        let rect = frame
//
//        animLayer.backgroundColor = UIColor.blue.cgColor // color of the layer, feel free to change
//        animLayer.frame = CGRect(x: rect.width-layerSize*0.5, y: rect.height-layerSize*0.5, width: layerSize, height: layerSize)
//        animLayer.cornerRadius = layerSize*0.5;
//        animLayer.anchorPoint = CGPoint(x: 1, y: 1) // sets so that when the width is changed, it goes to the left
//        layer.addSublayer(animLayer)
//
//        // decreases the corner radius
//        cornerRadiusAnim.duration = animDuration
//        cornerRadiusAnim.fromValue = animLayer.cornerRadius
//        cornerRadiusAnim.toValue = 0;
//        cornerRadiusAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut) // timing function to make it look nice
//
//        // increases the width
//        widthAnim.duration = animDuration
//        widthAnim.fromValue = animLayer.frame.size.width
//        widthAnim.toValue = rect.size.width
//        widthAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut) // timing function to make it look nice
//
//        // adds both animations to a group animation
//        groupAnim.animations = [cornerRadiusAnim, widthAnim]
//        groupAnim.duration = animDuration;
//        groupAnim.autoreverses = false; // auto-reverses the animation once completed
//
//        animLayer.add(groupAnim, forKey: "anim")
    }
    
    
    
    func roudThecornors(){
//        let radius = frame.width/2
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight,.topLeft], cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//
//        //setup Border for Mask
//        let borderLayer = CAShapeLayer()
//        borderLayer.path = path.cgPath
//        borderLayer.lineWidth = 1
//        borderLayer.strokeColor = UIColor.seperatorColor.cgColor
//        borderLayer.fillColor = UIColor.clear.cgColor
//        self.layer.addSublayer(borderLayer)
        self.layer.cornerRadius = frame.width/2
        layer.borderColor = UIColor.seperatorColor.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
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

