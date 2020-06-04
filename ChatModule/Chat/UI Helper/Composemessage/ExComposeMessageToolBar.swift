import UIKit

//MARK: - AUDIO STACK VIEW
extension ComposeMessageToolBar {
    
    
    func microPhoneImg()->(UIView,UIImageView){
        let containerView = UIView()
        let widthContraint = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        containerView.addConstraint(widthContraint)
        containerView.setContentHuggingPriority(.required, for: .horizontal)
        containerView.backgroundColor = .red
        
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
        button.setTitle("slide to cancel  <", for: .normal)
        button.setTitleColor(.gray, for: .normal)
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
//        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }
}
