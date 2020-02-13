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
        sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
    }
    
}
