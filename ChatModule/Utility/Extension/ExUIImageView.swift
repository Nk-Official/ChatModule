//
//  ExUIImageView.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 12/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import SDWebImage
extension UIImageView{
    
    func setImage(from url : String, placeholderImage : UIImage? = UIImage(named: "placeholderImg") ){
        image = placeholderImage
        sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
    }
    
    
    func setImage(from url : String, placeholderImage : UIImage? = UIImage(named: "placeholderImg"),startLoading: ()->(), endLoading: @escaping ()->() ){
        startLoading()
        image = placeholderImage
        sd_setImage(with: URL(string: url), placeholderImage: placeholderImage, options: .continueInBackground) { (_, _, _, _) in
            endLoading()
        }
    }
}
