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
       @IBOutlet weak var nameLbl : UIImageView!
       @IBOutlet weak var dateLbl : UIImageView!
       //MARK: - IBACTION
        @IBAction func star(_ sender: UIButton){
              
          }
          @IBAction func forward(_ sender: UIButton){
              
          }
          @IBAction func more(_ sender: UIButton){
              
          }
       //MARK: - VARIABLES

       //MARK: - OVERRIDEN
        override func viewDidLoad() {
            super.viewDidLoad()
            setUI()
        }
       //MARK: - UI SETUP
       func setUI(){
           
       }
       //MARK: - NETWORK CALL

}
