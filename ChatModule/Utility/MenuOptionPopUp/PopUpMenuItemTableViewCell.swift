//
//  PopUpMenuItemTableViewCell.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 28/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class PopUpMenuItemTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var iconImgView : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(menu item: PopUpMenuItem){
        titleLbl.text = item.title
        iconImgView.image = item.image
        iconImgView.isHidden = item.image == nil
    }

}
