//
//  ImageMessageViewerViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit
class ImageMessageViewerViewController : UIViewController{
    
    //MARK: - IBOUTLET
      @IBOutlet weak var imageView : UIImageView!
      @IBOutlet weak var nameLbl : UILabel!
       @IBOutlet weak var dateLbl : UILabel!
       //MARK: - IBACTION
        @IBAction func star(_ sender: UIButton){
              
        }
        @IBAction func forward(_ sender: UIButton){
              
        }
        @IBAction func more(_ sender: UIButton){
              
        }
       //MARK: - VARIABLES
    var image : UIImage!
    var name: String?
    var date: String?
    //MARK: - OVERRIDEN
     override func viewDidLoad() {
         super.viewDidLoad()
         setUI()
     }
    //MARK: - UI SETUP
    func setUI(){
        imageView.image = image
        nameLbl.text = name
        dateLbl.text = date
    }
    //MARK: - NETWORK CALL

}
