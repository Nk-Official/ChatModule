//
//  PopUpMenuItem.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 28/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation

struct PopUpMenuItem{
    let title: String
    let image: UIImage?
    let tapAction: (Int,PopUpMenuItem)->()// position
}
