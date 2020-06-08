import UIKit

//MARK: - AUDIO STACK VIEW
extension ComposeMessageToolBar {
    
    
    func microPhoneImg()->(UIView,UIImageView){
        let containerView = UIView()
        let widthContraint = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        let heightContraint = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: frame.height)

        containerView.addConstraint(widthContraint)
        containerView.addConstraint(heightContraint)

        containerView.setContentHuggingPriority(.required, for: .horizontal)
        
        let microPhnBtn = UIImage(named: "microphoneFilledGray")
        let imageView = UIImageView(image: microPhnBtn)
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size.width = 40
        imageView.setContentHuggingPriority(.required, for: .horizontal)
//        imageView.backgroundColor = .white
        
        containerView.addSubview(imageView)
        return (containerView,imageView)
        
    }
    
    func slideToCancelButton()->UIButton{
        
        let button = UIButton()
        button.setTitle("slide to cancel  ", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.setImage(UIImage(named: "back4Gray") , for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
        
    }
    
    func getTimerLbl()->UILabel{
        let label = UILabel()
        label.text = ""
        let widthContraint = NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: timerLblWidth)
        label.addConstraint(widthContraint)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
//        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }
}
