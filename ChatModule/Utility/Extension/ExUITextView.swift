//
//  ExUITextView.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 27/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit


extension UITextView {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font?.lineHeight  ?? 0
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}

