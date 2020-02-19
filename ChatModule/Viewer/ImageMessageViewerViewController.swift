//
//  ImageMessageViewerViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import RxSwift
import RxCocoa
class ImageMessageViewerViewController : UIViewController{
    
    //MARK: - IBOUTLET
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var starButton : UIButton!
    @IBOutlet weak var starImageView : UIImageView!
    @IBOutlet weak var shareBtn : UIButton!
    @IBOutlet weak var morebtn : UIButton!

    
   //MARK: - IBACTION
    @IBAction func star(_ sender: UIButton){
        favorite.accept(!favorite.value)
    }
    @IBAction func forward(_ sender: UIButton){
          
    }
    @IBAction func more(_ sender: UIButton){
          
    }
    @IBAction func back(_ sender: UIButton){
          dismiss(animated: true, completion: nil)
    }
       //MARK: - VARIABLES
    var image : UIImage!
    var name: String?
    var date: String?
    private var disposeBag: DisposeBag = DisposeBag()
    private var favorite: BehaviorRelay<Bool> = BehaviorRelay(value:false)
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //MARK: - OVERRIDEN
     override func viewDidLoad() {
        super.viewDidLoad()
        setPrefrences()
        setUI()
        bindable()
     }
    //MARK: - UI SETUP
    func setUI(){
        imageView.image = image
        nameLbl.text = name
        dateLbl.text = date
        scrollView.delegate = self
    }
    func setPrefrences(){
        starButton.isHidden = !ChatPrefrences.shared.imageViewerPrefrences.canMarkFavorite
        shareBtn.isHidden = !ChatPrefrences.shared.imageViewerPrefrences.canForward
    }
    //MARK: - BINDABLE
    func bindable(){
        if ChatPrefrences.shared.imageViewerPrefrences.canMarkFavorite{
            favorite.subscribe { (_) in
                self.starImageView.image = self.favorite.value ? UIImage(named: "filledWhiteStar") : UIImage(named: "hollowWhiteStar")
            }.disposed(by: disposeBag)
        }
    }
    //MARK: - NETWORK CALL

}

extension ImageMessageViewerViewController : UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
