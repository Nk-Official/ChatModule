//
//  MediaTableViewCell.swift
//  ChatModule
//
//  Created by user on 14/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    //MARK: - OUTLET
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var subHeadingLbl: UILabel!
    @IBOutlet weak var disclosureLbl: UILabel!
    @IBOutlet weak var typeImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(data: ContactInfoTableData){
        
        headingLbl.text = data.title
        subHeadingLbl.text = data.subtitle
        disclosureLbl.text = data.diclusreTitle
        typeImgView.image = data.typeImage
        typeImgView.isHidden = data.typeImage == nil
    }
}
