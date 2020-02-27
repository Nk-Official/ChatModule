//
//  ExViewController.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 24/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import UIKit

extension UIViewController{
    //MARK: - alertForEnableLocation
    func alertForEnableLocation(){
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)

        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String?, message: String?, okAction: ((UIAlertAction)->())?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okaction = UIAlertAction(title: "OK", style: .default, handler: okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        if okAction != nil{
            alertController.addAction(okaction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
