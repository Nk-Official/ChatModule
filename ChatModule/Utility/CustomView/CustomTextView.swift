//
//  CustomTextView.swift
//  XRentY
//
//  Created by Namrata Khanduri on 22/10/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation
import RxSwift
class CustomTextView : UITextView, UITextViewDelegate{
    
    @IBInspectable var placeholder : String = ""
    @IBInspectable var placeholderColor : UIColor = .lightGray
    @IBInspectable var tftextColor : UIColor = .black

    var editingEnd : ((String?,CustomTextView)->())?
    var editingChanged : ((String?,CustomTextView)->())?

    private let disposableBag = DisposeBag()
    
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        self.delegate = self
        setPlaceHolder()
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.textColor == placeholderColor{
            removePlaceholder()
            
        }
        editingChanged?(textView.text,self)
      
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        moveCurserToFirstPosition()
        removePlaceholder()
        editingChanged?(textView.text,self)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0{
            setPlaceHolder()
        }
        editingEnd?(textView.text,self)
         editingChanged?(textView.text,self)
    }
    func getText()->String{
        if self.textColor == placeholderColor{
            return ""
        }
        return self.text
    }
    func setText(text : String){
        if text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0{
            setPlaceHolder()
        }
        else{
            self.text = text
            self.textColor = tftextColor
        }
         editingChanged?(self.text,self)
    }
    func setPlaceHolder(){
        self.text = placeholder
        self.textColor = placeholderColor
        moveCurserToFirstPosition()
    }
    func removePlaceholder(){
        self.text = ""
        self.textColor =  tftextColor
    }
    
    func moveCurserToFirstPosition(){
        let newPosition = self.beginningOfDocument
        self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
    }
    override func shouldChangeText(in range: UITextRange, replacementText text: String) -> Bool {
    
        if (text == "\n")
        {
            setText(text: text + "\n")
            //textView.resignFirstResponder()
            
        }
        return true
    }
}
