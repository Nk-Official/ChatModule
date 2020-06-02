import UIKit

//MARK: - AUDIO STACK VIEW
extension ComposeMessageToolBar {
    
    
    
    func createAudioMessageStackView(){
        microPhnImageView = microPhoneImg()
        slideToCancelBtn = slideToCancelButton()
        timerLbl = getTimerLbl()
        
        let stckView = UIStackView()
        stckView.axis = .horizontal
       
        stckView.spacing = 10
//        stckView.alignment = .bottom
        stckView.addArrangedSubview(microPhnImageView!)
        stckView.addArrangedSubview(timerLbl!)
        stckView.addArrangedSubview(slideToCancelBtn!)

        self.audioMessageStackView = stckView
        audioMessageStackView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 2.5, right: 0)
        audioMessageStackView?.isLayoutMarginsRelativeArrangement = true
    }
    
    
    func microPhoneImg()->UIImageView{
        
        let microPhnBtn = UIImage(named: "microphoneBlue")
        let imageView = UIImageView(image: microPhnBtn)
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size.width = 40
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        return imageView
        
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
        label.frame.size =  CGSize(width: 100, height: self.frame.height)
        label.backgroundColor = .white
//        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }
}
