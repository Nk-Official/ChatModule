//
//  AttachmentActionSheet.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import ContactsUI

protocol AttachmentActionSheetDelegate {
    func didPickImage(sheet : AttachmentActionSheet, image : UIImage)
    func didPickVideo(sheet : AttachmentActionSheet, videoUrl : URL)
    func didPickDocument(sheet : AttachmentActionSheet, urls : [URL])
    func didPickContacts(sheet : AttachmentActionSheet, contacts : [CNContact])
}

class AttachmentActionSheet : NSObject{
    
    let pickerController = UIImagePickerController()
    let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF),String(kUTTypeContact)], in: .import)
    var delegate : AttachmentActionSheetDelegate?
    var viewController : UIViewController!
    var actionSheet : UIAlertController!
    let contactPickerViewController = CNContactPickerViewController()
    var locationPickerDelegate: LocationPickerDelegate?
    
    init(delegate : AttachmentActionSheetDelegate? = nil) {
        
        super.init()
        self.assignValueInViewc()
        pickerController.delegate = self
        
        self.delegate = delegate
        
        self.createActionSheet()
    }
    
    
    func presentActionSheet(){
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    func createActionSheet(){
        actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cam_action = cameraAction()
        let library_action = photoAndCamLibraryAction()
        let document_action = documentAction()
        let location_action = locationAction()
        let contact_action = contactAction()
        let cancel_action = cancelAction()
        [cam_action,library_action,document_action,location_action,contact_action,cancel_action].forEach { (action) in
            actionSheet.addAction(action)
        }
    }
    func assignValueInViewc(){
        if let topController = UIApplication.shared.keyWindow?.rootViewController{
            self.viewController = topController
        }
    }
}

extension AttachmentActionSheet : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage  {
            delegate?.didPickImage(sheet: self, image: image)
        }
        else if let videoURL = info[.mediaURL] as? URL{
            delegate?.didPickVideo(sheet: self, videoUrl: videoURL)
        }
        viewController.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
extension AttachmentActionSheet :UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        delegate?.didPickDocument(sheet: self, urls: urls)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}


//https://iosdevcenters.blogspot.com/2016/07/show-contact-list-in-swift.html
extension AttachmentActionSheet: CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        for i in contact.phoneNumbers{
            print("contact",contact.givenName,i.value)
        }
        delegate?.didPickContacts(sheet: self, contacts: [contact])
    }
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            for number in contact.phoneNumbers {
                let phoneNumber = number.value
                print("number is = \(phoneNumber)")
            }
        }
        delegate?.didPickContacts(sheet: self, contacts: contacts)
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
