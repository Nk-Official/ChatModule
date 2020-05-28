import UIKit

//MARK: - AUDIO STACK VIEW
extension ComposeMessageToolBar {
    
    
    
    func createAudioMessageStackView(){
        let stckView = UIStackView()
        stckView.axis = .horizontal
       
        stckView.spacing = 10
        stckView.alignment = .bottom
        self.audioMessageStackView = stckView
        audioMessageStackView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 2.5, right: 0)
        audioMessageStackView?.isLayoutMarginsRelativeArrangement = true
        items = [UIBarButtonItem(customView: stckView) ]
    }
    
    
    func micro
    
}
