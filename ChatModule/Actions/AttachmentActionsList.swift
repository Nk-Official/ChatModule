//
//  AttachmentActionsList.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 19/11/19.
//  Copyright © 2019 Namrata Khanduri. All rights reserved.
//

import Foundation
import UIKit
import ContactsUI
extension AttachmentActionSheet{
    func cameraAction()->UIAlertAction{
        let action = UIAlertAction(title: "Camera", style: .default) { (_) in
            self.presentCamera()
        }
        
        return action
    }
    func photoAndCamLibraryAction()->UIAlertAction{
        let action = UIAlertAction(title: "Photos & Video Library", style: .default) { (_) in
            self.presentLibrary()
        }
        
        return action
    }
    func documentAction()->UIAlertAction{
        let action = UIAlertAction(title: "Document", style: .default) { (_) in
            self.presentDocumentPicker()
        }
        
        return action
    }
    func locationAction()->UIAlertAction{
        let action = UIAlertAction(title: "Location", style: .default) { (_) in
            
        }
        
        return action
    }
    func contactAction()->UIAlertAction{
        let action = UIAlertAction(title: "Contact", style: .default) { (_) in
            self.presentContactList()
        }
        
        return action
    }
    func cancelAction()->UIAlertAction{
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        return action
    }
}
extension AttachmentActionSheet{
    func presentCamera(){
        pickerController.sourceType = .camera
        //if the resizing & cropping interface should be presented after selecting & taking a picture
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image", "public.movie"]
        viewController.present(pickerController, animated: true, completion: nil)
    }
    func presentLibrary(){
        pickerController.sourceType = .photoLibrary
        //if the resizing & cropping interface should be presented after selecting & taking a picture
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image", "public.movie"]
        viewController.present(pickerController, animated: true, completion: nil)
    }
    func presentDocumentPicker(){
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.viewController.present(pickerController, animated: true, completion: nil)
    }
    func presentContactList(){
        contactPickerViewController.delegate = self
        viewController.present(contactPickerViewController, animated: true, completion: nil)
    }
}
